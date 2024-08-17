require_relative 'class_definition/presenter'
require_relative 'actions/definition'

module WamlToRails
  module Sources
    module Controllers
      class Definition
        def initialize(crud_definition:)
          @crud_definition = crud_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          ::WamlToRails::Utils::FormatCode.call(raw_content)
        end

        private

        def class_definition
          ::WamlToRails::Sources::Controllers::ClassDefinition::Presenter.new(table_name: @crud_definition.table).render
        end
      end
    end
  end
end
