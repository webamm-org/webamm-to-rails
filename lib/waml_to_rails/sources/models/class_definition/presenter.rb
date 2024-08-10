module WamlToRails
  module Sources
    module Models
      class ClassDefinition
        class Presenter
          def initialize(table_name:)
            @table_name = table_name
          end

          def render(base_class: 'ApplicationRecord')
            "class #{@table_name.classify} < #{base_class}"
          end
        end
      end
    end
  end
end
