require 'waml'
require 'active_support/all'

require 'waml_to_rails/utils/format_code'

require 'waml_to_rails/version'
require 'waml_to_rails/sources/models/definition'
require 'waml_to_rails/sources/migrations/files_list'
require 'waml_to_rails/sources/gemfile/definition'
require 'waml_to_rails/sources/routes/definition'
require 'waml_to_rails/sources/initializers/definitions'
require 'waml_to_rails/sources/views/definition'
require 'waml_to_rails/sources/helpers/definitions'
require 'waml_to_rails/sources/package_json/definition'
require 'waml_to_rails/features/definitions'
require 'waml_to_rails/sources/controllers/definition'

require 'waml_to_rails/rails_boilerplate/builder'

module WamlToRails
  class << self
    def generate(waml_json)
      files = ::WamlToRails::RailsBoilerplate::Builder.call

      waml_definition = ::Waml::Definition.new(waml_json.deep_symbolize_keys)

      # Models
      waml_definition.database.schema.each do |table_schema|
        model_code = ::WamlToRails::Sources::Models::Definition.new(
          table_definition: table_schema, waml_definition: waml_definition
        ).render

        files << {
          path: "app/models/#{table_schema.table.singularize}.rb",
          content: model_code
        }
      end

      # Controllers
      waml_definition.database.crud.each do |crud_definition|
        controller_code = ::WamlToRails::Sources::Controllers::Definition.new(
          crud_definition: crud_definition, waml_definition: waml_definition
        ).render

        files << {
          path: "app/controllers/#{crud_definition.table.pluralize}_controller.rb",
          content: controller_code
        }
      end

      # package.json
      files << {
        path: 'package.json',
        content: ::WamlToRails::Sources::PackageJson::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Gemfile
      files << {
        path: 'Gemfile',
        content: ::WamlToRails::Sources::Gemfile::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Routes
      files << {
        path: 'config/routes.rb',
        content: ::WamlToRails::Sources::Routes::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      # Initializers
      files |= ::WamlToRails::Sources::Initializers::Definitions.new(
        waml_definition: waml_definition
      ).collection

      # Migrations
      files |= ::WamlToRails::Sources::Migrations::FilesList.new(
        waml_definition: waml_definition, database_tables: waml_definition.database.schema
      ).collection

      # Views
      files |= ::WamlToRails::Sources::Views::Definition.new(
        waml_definition: waml_definition
      ).collection

      # Helpers
      files |= ::WamlToRails::Sources::Helpers::Definitions.new(
        waml_definition: waml_definition
      ).collection

      # Features
      files |= ::WamlToRails::Features::Definitions.new(
        waml_definition: waml_definition
      ).collection

      files
    end
  end
end
