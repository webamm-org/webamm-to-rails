module WebammToRails
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

            base_actions = @crud_definition.actions.map(&:name)
            base_actions << 'edit' if base_actions.include?('update')
            base_actions << 'new' if base_actions.include?('create')

            base_def + ", only: %i[#{base_actions.join(' ')}]"
          end
        end
      end
    end
  end
end
