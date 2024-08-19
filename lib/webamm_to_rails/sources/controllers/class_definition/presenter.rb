module WebammToRails
  module Sources
    module Controllers
      class ClassDefinition
        class Presenter
          def initialize(table_name:)
            @table_name = table_name
          end

          def render(base_class: 'ApplicationController')
            "class #{@table_name.classify.pluralize}Controller < #{base_class}"
          end
        end
      end
    end
  end
end
