require_relative 'new_definition/presenter'
require_relative 'edit_definition/presenter'
require_relative 'show_definition/presenter'
require_relative 'destroy_definition/presenter'
require_relative 'create_definition/presenter'
require_relative 'update_definition/presenter'
require_relative 'strong_parameters_definition/presenter'

module WamlToRails
  module Sources
    module Controllers
      module Actions
        class Definition
          def initialize(crud_definition:)
            @crud_definition = crud_definition
          end
        end
      end
    end
  end
end
