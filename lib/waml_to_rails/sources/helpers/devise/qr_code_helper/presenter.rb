module WamlToRails
  module Sources
    module Helpers
      module Devise
        module QrCodeHelper
          class Presenter
            def render
              template_path = File.expand_path('template.erb', __dir__)
              template_content = File.read(template_path)
              raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

              ::WamlToRails::Utils::FormatCode.call(raw_content)
            end
          end
        end
      end
    end
  end
end
