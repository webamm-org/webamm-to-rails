require_relative 'devise/presenter'

module WamlToRails
  module Sources
    module Views
      class Definition
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          views = []
          views |= ::WamlToRails::Sources::Views::Devise::Presenter.new(waml_definition: @waml_definition).collection
          views
        end
      end
    end
  end
end
