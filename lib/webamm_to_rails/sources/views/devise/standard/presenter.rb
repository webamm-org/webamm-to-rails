module WebammToRails
  module Sources
    module Views
      module Devise
        module Standard
          class Presenter
            def initialize(table_name:)
              @table_name = table_name
            end

            def collection
              base_path = "app/views/#{@table_name}/"
              templates = [
                'confirmations/new.html.erb',
                'mailer/confirmation_instructions.html.erb',
                'mailer/reset_password_instructions.html.erb',
                'mailer/email_changed.html.erb',
                'mailer/password_change.html.erb',
                'passwords/edit.html.erb',
                'passwords/new.html.erb',
                'registrations/edit.html.erb',
                'registrations/new.html.erb',
                'sessions/new.html.erb',
                'shared/_links.html.erb'
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
