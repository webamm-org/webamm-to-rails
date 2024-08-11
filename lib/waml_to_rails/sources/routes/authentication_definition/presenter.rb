module WamlToRails
  module Sources
    module Routes
      module AuthenticationDefinition
        class Presenter
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def render
            return if @waml_definition.authentication.blank?

            @waml_definition.authentication.map do |authentication|
              "devise_for :#{authentication.table}"
            end.join("\n")
          end
        end
      end
    end
  end
end
