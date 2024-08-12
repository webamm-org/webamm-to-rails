require_relative 'devise_definition/presenter'

module WamlToRails
  module Sources
    module Initializers
      class Definitions
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          base_collection = []

          if @waml_definition.authentication.present?
            base_collection << {
              path: 'config/initializers/devise.rb',
              content: DeviseDefinition::Presenter.new(waml_definition: @waml_definition).render
            }
          end

          base_collection
        end
      end
    end
  end
end
