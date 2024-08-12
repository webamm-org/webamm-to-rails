require_relative 'devise/presenter'

module WamlToRails
  module Sources
    module Helpers
      class Definitions
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          base_collection = []

          base_collection |= ::WamlToRails::Sources::Helpers::Devise::Presenter.new(waml_definition: @waml_definition).collection

          base_collection
        end
      end
    end
  end
end
