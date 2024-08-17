module WamlToRails
  module Sources
    module Views
      module Resource
        module ShowDefinition
          class Presenter
            def initialize(crud_definition:)
              @crud_definition = crud_definition
            end

            def render?
              @crud_definition.actions.find { |action| action.name == 'show' }.present?
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })
              
              ::WamlToRails::Utils::FormatTemplate.call(raw_content)
            end

            def path_name
              "app/views/#{resource_name}/show.html.erb"
            end

            private

            def resource_name
              @crud_definition.table
            end

            def title
              @crud_definition.table.singularize.humanize
            end

            def enabled?(view_action)
              @crud_definition.actions.find { |action| action.name == view_action }.present?
            end

            def resource_singular_name
              @crud_definition.table.singularize
            end

            def edit_resource_path
              "edit_#{resource_name.singularize}_path(@#{resource_name.singularize})"
            end

            def index_resource_path
              "#{@crud_definition.table}_path"
            end

            def model_attributes
              @crud_definition.actions.find { |action| action.name == 'show' }.options.model_attributes
            end
          end
        end
      end
    end
  end
end
