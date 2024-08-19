require_relative 'devise/presenter'

module WebammToRails
  module Sources
    module Helpers
      class Definitions
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          base_collection = []

          base_collection |= ::WebammToRails::Sources::Helpers::Devise::Presenter.new(waml_definition: @waml_definition).collection

          base_collection
        end
      end
    end
  end
end
