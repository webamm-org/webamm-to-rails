module WamlToRails
  module Sources
    module Initializers
      module DeviseDefinition
        class Presenter
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def render
            template_path = File.expand_path('template.erb', __dir__)
            template_content = File.read(template_path)
            raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

            ::WamlToRails::Utils::FormatCode.call(raw_content)
          end

          private

          def features
            @waml_definition.authentication.map(&:features).flatten.uniq
          end
        end
      end
    end
  end
end
