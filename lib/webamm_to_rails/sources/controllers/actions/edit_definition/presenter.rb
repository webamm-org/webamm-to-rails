module WebammToRails
  module Sources
    module Controllers
      module Actions
        module EditDefinition
          class Presenter
            def initialize(table_name:, crud_definition:)
              @table_name = table_name
              @crud_definition = crud_definition
            end

            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

              ::WebammToRails::Utils::FormatCode.call(raw_content)
            end

            def access_scope = :public

            def render?
              @crud_definition.actions.find { |action| action.name == 'update' }.present?
            end

            private

            def variable_name
              "@#{@table_name.singularize}"
            end

            def find_call
              "#{@table_name.classify}.find(params[:id])"
            end
          end
        end
      end
    end
  end
end
