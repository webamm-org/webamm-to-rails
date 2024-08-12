module WamlToRails
  module Features
    module DeviseOnlineable
      module Definitions
        module Connection
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

            def devise_models
              @waml_definition.authentication.select { |auth| auth.features.include?('online_indication') }.map(&:table).map(&:singularize)
            end
          end
        end
      end
    end
  end
end
