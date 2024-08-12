require 'json'

module WamlToRails
  module Sources
    module PackageJson
      class Definition
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          JSON.parse(raw_content)
        end

        private

        def use_actioncable?
          @waml_definition.authentication.present? && @waml_definition.authentication.any? { |auth| auth.features.include?('online_indication') }
        end
      end
    end
  end
end
