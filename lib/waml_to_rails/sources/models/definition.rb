require_relative 'class_definition/presenter'

module WamlToRails
  module Sources
    module Models
      class Definition
        def initialize(table_name:, waml_definition:)
          @table_name = table_name
          @waml_definition = waml_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)

          ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })
        end

        private

        def class_definition
          ::WamlToRails::Sources::Models::ClassDefinition::Presenter.new(table_name: @table_name).render
        end
      end
    end
  end
end
