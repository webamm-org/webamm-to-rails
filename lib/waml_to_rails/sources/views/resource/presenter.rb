require_relative 'index_definition/presenter'

module WamlToRails
  module Sources
    module Views
      module Resource
        class Presenter
          def initialize(crud_definition:)
            @crud_definition = crud_definition
          end

          def collection
            []
          end
        end
      end
    end
  end
end
