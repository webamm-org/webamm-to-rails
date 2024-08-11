require 'active_support/all'

require 'waml_to_rails/definition'
require 'waml_to_rails/utils/format_code'

require 'waml_to_rails/version'
require 'waml_to_rails/sources/models/definition'
require 'waml_to_rails/sources/migrations/files_list'
require 'waml_to_rails/sources/gemfile/definition'
require 'waml_to_rails/sources/routes/definition'

require 'waml_to_rails/rails_boilerplate/builder'

module WamlToRails
  class << self
    def generate(waml_json)
      files = ::WamlToRails::RailsBoilerplate::Builder.call

      waml_definition = ::WamlToRails::Definition.new(waml_json.deep_symbolize_keys)

      waml_definition.database.schema.each do |table_schema|
        model_code = ::WamlToRails::Sources::Models::Definition.new(
          table_definition: table_schema, waml_definition: waml_definition
        ).render

        files << {
          path: "app/models/#{table_schema.table.singularize}.rb",
          content: model_code
        }
      end

      files << {
        path: 'Gemfile',
        content: ::WamlToRails::Sources::Gemfile::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      files << {
        path: 'config/routes.rb',
        content: ::WamlToRails::Sources::Routes::Definition.new(
          waml_definition: waml_definition
        ).render
      }

      files | ::WamlToRails::Sources::Migrations::FilesList.new(
        waml_definition: waml_definition, database_tables: waml_definition.database.schema
      ).collection
    end
  end
end
