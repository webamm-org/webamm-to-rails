require_relative 'new_definition/presenter'
require_relative 'edit_definition/presenter'
require_relative 'show_definition/presenter'
require_relative 'destroy_definition/presenter'

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
