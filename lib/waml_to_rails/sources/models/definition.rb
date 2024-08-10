require_relative 'class_definition/presenter'
require_relative 'association_definition/presenter'
require_relative 'associations'

module WamlToRails
  module Sources
    module Models
      class Definition
        def initialize(table_definition:, waml_definition:)
          @table_definition = table_definition
          @waml_definition = waml_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          ::WamlToRails::Utils::FormatCode.call(raw_content)
        end

        private

        def class_definition
          ::WamlToRails::Sources::Models::ClassDefinition::Presenter.new(table_name: table_name).render
        end

        def associations
          ::WamlToRails::Sources::Models::Associations.new(table_definition: @table_definition, waml_definition: @waml_definition).collection
        end

        def table_name
          @table_definition['table']
        end
      end
    end
  end
end
