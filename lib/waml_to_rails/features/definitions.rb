require_relative 'devise_onlineable/definition'

module WamlToRails
  module Features
    class Definitions
      def initialize(waml_definition:)
        @waml_definition = waml_definition
      end

      def collection
        features = []

        features |= ::WamlToRails::Features::DeviseOnlineable::Definition.new(waml_definition: @waml_definition).collection

        features
      end
    end
  end
end
