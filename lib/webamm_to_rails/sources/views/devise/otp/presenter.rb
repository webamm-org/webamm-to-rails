module WebammToRails
  module Sources
    module Views
      module Devise
        module Otp
          class Presenter
            def collection
              base_path = "app/views/devise/"
              templates = [
                'otp_credentials/show.html.erb',
                'otp_credentials/refresh.html.erb',
                'otp_tokens/_token_secret.html.erb',
                'otp_tokens/_trusted_devices.html.erb',
                'otp_tokens/edit.html.erb',
                'otp_tokens/recovery_codes.html.erb',
                'otp_tokens/recovery.html.erb',
                'otp_tokens/show.html.erb'
              ]

              templates.map do |template|
                {
                  path: base_path + template,
                  content: File.read(File.expand_path("templates/#{template}", __dir__))
                }
              end
            end
          end
        end
      end
    end
  end
end
