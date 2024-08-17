module WamlToRails
  module Sources
    module Controllers
      module Actions
        module StrongParametersDefinition
          class Presenter
            def initialize(crud_definition:, waml_definition:)
              @crud_definition = crud_definition
              @waml_definition = waml_definition
            end

            def render?
              @crud_definition.actions.any? { |action| action.name.in?(%w[create update]) }
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

              ::WamlToRails::Utils::FormatCode.call(raw_content)
            end

            def access_scope = :private

            private

            def method_name
              "def #{@crud_definition.table.singularize}_params"
            end

            def param_name
              ":#{@crud_definition.table.singularize}"
            end

            def permitted_attributes
              model_definition.columns.map(&:name).map { |name| ":#{name}" }.join(', ')
            end

            def model_definition
              @model_definition ||= @waml_definition.database.schema.find do |definition|
                definition.table == @crud_definition.table
              end
            end
          end
        end
      end
    end
  end
end
