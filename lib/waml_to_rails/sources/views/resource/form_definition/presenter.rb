module WamlToRails
  module Sources
    module Views
      module Resource
        module FormDefinition
          class Presenter
            def initialize(crud_definition:, waml_definition:)
              @crud_definition = crud_definition
              @waml_definition = waml_definition
            end

            def render?
              @crud_definition.actions.find { |action| action.name == 'create' || action.name == 'update' }.present?
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })
              
              ::WamlToRails::Utils::FormatTemplate.call(raw_content)
            end

            def path_name
              "app/views/#{resource_name}/_form.html.erb"
            end

            private

            def singular_resource_name
              resource_name.singularize
            end

            def resource_name
              @crud_definition.table
            end

            def columns
              @waml_definition.database.schema.find { |schema| schema.table == @crud_definition.table }.columns
            end

            def class_name
              resource_name.classify
            end

            # def title
            #   @crud_definition.table.humanize
            # end

            # def enabled?(view_action)
            #   @crud_definition.actions.find { |action| action.name == view_action }.present?
            # end

            # def new_resource_path
            #   "new_#{resource_name.singularize}_path"
            # end

            # def edit_resource_path
            #   "edit_#{resource_name.singularize}_path(#{resource_name.singularize})"
            # end

            # def resource_path
            #   "#{resource_name.singularize}_path(#{resource_name.singularize})"
            # end

            # def singular_variable
            #   resource_name.singularize
            # end

            # def plural_variable
            #   resource_name 
            # end

            # def model_attributes
            #   @crud_definition.actions.find { |action| action.name == 'index' }.options.model_attributes
            # end
          end
        end
      end
    end
  end
end
