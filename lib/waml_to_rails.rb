require 'active_support/all'
require 'pry'

require 'waml_to_rails/definition'
require 'waml_to_rails/utils/format_code'

require 'waml_to_rails/version'
require 'waml_to_rails/sources/models/definition'

require 'waml_to_rails/sources/migrations/class_definition/presenter'

module WamlToRails
  class << self
    def generate(waml_json)
      waml_definition = ::WamlToRails::Definition.new(waml_json.deep_symbolize_keys)

      waml_definition.database.schema.each do |table_schema|
        model_code = ::WamlToRails::Sources::Models::Definition.new(
          table_definition: table_schema, waml_definition: waml_definition
        ).render
      end
    end
  end
end
