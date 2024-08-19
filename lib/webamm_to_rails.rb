require 'webamm'
require 'active_support/all'

require 'webamm_to_rails/utils/format_code'
require 'webamm_to_rails/utils/format_template'

require 'webamm_to_rails/version'
require 'webamm_to_rails/sources/models/definition'
require 'webamm_to_rails/sources/migrations/files_list'
require 'webamm_to_rails/sources/gemfile/definition'
require 'webamm_to_rails/sources/routes/definition'
require 'webamm_to_rails/sources/initializers/definitions'
require 'webamm_to_rails/sources/views/definition'
require 'webamm_to_rails/sources/helpers/definitions'
require 'webamm_to_rails/sources/package_json/definition'
require 'webamm_to_rails/features/definitions'
require 'webamm_to_rails/sources/controllers/definition'
require 'webamm_to_rails/sources/controllers/application_controller/definition'

require 'webamm_to_rails/rails_boilerplate/builder'

module WebammToRails
  class << self
    def generate(waml_json)
      files = ::WebammToRails::RailsBoilerplate::Builder.call

      waml_definition = ::Webamm::Definition.new(waml_json.deep_symbolize_keys)

      # Models
      waml_definition.database.schema.each do |table_schema|
        model_code = ::WebammToRails::Sources::Models::Definition.new(
          table_definition: table_schema, waml_definition: waml_definition
        ).render

        files << {
          path: "app/models/#{table_schema.table.singularize}.rb",
          content: model_code
        }
      end

      # Controllers
      waml_definition.database.crud.each do |crud_definition|
        controller_code = ::WebammToRails::Sources::Controllers::Definition.new(
          crud_definition: crud_definition, waml_definition: waml_definition
        ).render

        files << {
          path: "app/controllers/#{crud_definition.table.pluralize}_controller.rb",
          content: controller_code
        }
      end

      files << {
        path: 'app/controllers/application_controller.rb',
        content: ::WebammToRails::Sources::Controllers::ApplicationController::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # package.json
      files << {
        path: 'package.json',
        content: ::WebammToRails::Sources::PackageJson::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Gemfile
      files << {
        path: 'Gemfile',
        content: ::WebammToRails::Sources::Gemfile::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Routes
      files << {
        path: 'config/routes.rb',
        content: ::WebammToRails::Sources::Routes::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Initializers
      files |= ::WebammToRails::Sources::Initializers::Definitions.new(
        waml_definition: waml_definition
      ).collection

      # Migrations
      files |= ::WebammToRails::Sources::Migrations::FilesList.new(
        waml_definition: waml_definition, database_tables: waml_definition.database.schema
      ).collection

      # Views
      files |= ::WebammToRails::Sources::Views::Definition.new(
        waml_definition: waml_definition
      ).collection

      # Helpers
      files |= ::WebammToRails::Sources::Helpers::Definitions.new(
        waml_definition: waml_definition
      ).collection

      # Features
      files |= ::WebammToRails::Features::Definitions.new(
        waml_definition: waml_definition
      ).collection

      files
    end
  end
end
