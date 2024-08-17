require_relative 'new_definition/presenter'
require_relative 'edit_definition/presenter'
require_relative 'show_definition/presenter'
require_relative 'destroy_definition/presenter'
require_relative 'create_definition/presenter'
require_relative 'update_definition/presenter'
require_relative 'index_definition/presenter'
require_relative 'strong_parameters_definition/presenter'

module WamlToRails
  module Sources
    module Controllers
      module Actions
        class Definition
          def initialize(crud_definition:, waml_definition:)
            @crud_definition = crud_definition
            @waml_definition = waml_definition
          end

          def collection
            actions.select(&:render?).group_by(&:access_scope)
          end

          private

          def actions
            [
              ::WamlToRails::Sources::Controllers::Actions::IndexDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::NewDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::EditDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::ShowDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::DestroyDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::CreateDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::UpdateDefinition::Presenter.new(
                table_name: @crud_definition.table,
                crud_definition: @crud_definition
              ),
              ::WamlToRails::Sources::Controllers::Actions::StrongParametersDefinition::Presenter.new(
                crud_definition: @crud_definition,
                waml_definition: @waml_definition
              )
            ]
          end
        end
      end
    end
  end
end
