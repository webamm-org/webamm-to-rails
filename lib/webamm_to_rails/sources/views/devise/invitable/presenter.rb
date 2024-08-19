module WebammToRails
  module Sources
    module Views
      module Devise
        module Invitable
          class Presenter
            def initialize(table_name:)
              @table_name = table_name
            end

            def collection
              base_path = "app/views/#{@table_name}/"
              templates = [
                'mailer/invitation_instructions.html.erb',
                'invitations/edit.html.erb',
                'invitations/new.html.erb'
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
