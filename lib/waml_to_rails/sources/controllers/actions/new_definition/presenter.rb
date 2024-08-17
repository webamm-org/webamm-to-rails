module WamlToRails
  module Sources
    module Controllers
      module Actions
        module NewDefinition
          class Presenter
            def initialize(table_name:, crud_definition:)
              @table_name = table_name
              @crud_definition = crud_definition
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

              ::WamlToRails::Utils::FormatCode.call(raw_content)
            end

            def access_scope = :public

            def render?
              @crud_definition.actions.find { |action| action.name == 'create' }.present?
            end

            private

            def variable_name
              "@#{@table_name.singularize}"
            end

            def new_call
              "#{@table_name.classify}.new"
            end
          end
        end
      end
    end
  end
end
