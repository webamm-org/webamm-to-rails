require_relative 'devise_definition/presenter'

module WamlToRails
  module Sources
    module Controllers
      module Filters
        class Definition
          def initialize(crud_definition:, waml_definition:)
            @crud_definition = crud_definition
            @waml_definition = waml_definition
          end

          def collection
            base_collection = []

            base_collection |= devise_collection

            base_collection
          end

          private

          def devise_collection
            ::WamlToRails::Sources::Controllers::Filters::DeviseDefinition::Presenter.new(
              crud_definition: @crud_definition, waml_definition: @waml_definition
            ).collection
          end
        end
      end
    end
  end
end
