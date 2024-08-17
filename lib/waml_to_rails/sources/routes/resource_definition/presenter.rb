module WamlToRails
  module Sources
    module Routes
      module ResourceDefinition
        class Presenter
          def initialize(crud_definition:)
            @crud_definition = crud_definition
          end

          def render
            base_def = "resources :#{@crud_definition.table}"

            return base_def if @crud_definition.actions.size == 7

            base_def + ", only: %i[#{@crud_definition.actions.map(&:name).join(' ')}]"
          end
        end
      end
    end
  end
end
