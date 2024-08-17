module WamlToRails
  module Sources
    module Views
      module Resource
        module EditDefinition
          class Presenter
            def initialize(crud_definition:)
              @crud_definition = crud_definition
            end

            def render?
              @crud_definition.actions.find { |action| action.name == 'update' }.present?
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })
              
              ::WamlToRails::Utils::FormatTemplate.call(raw_content)
            end

            def path_name
              "app/views/#{resource_name}/edit.html.erb"
            end

            private

            def resource_name
              @crud_definition.table
            end

            def single_record_name
              @crud_definition.table.singularize
            end
          end
        end
      end
    end
  end
end
