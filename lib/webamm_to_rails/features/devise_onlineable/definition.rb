require_relative 'definitions/connection/presenter'

module WebammToRails
  module Features
    module DeviseOnlineable
      class Definition
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          return [] if @waml_definition.authentication.none? { |auth| auth.features.include?('online_indication') }

          [
            {
              path: 'app/channels/application_cable/connection.rb',
              content: ::WebammToRails::Features::DeviseOnlineable::Definitions::Connection::Presenter.new(waml_definition: @waml_definition).render
            },
            {
              path: 'app/channels/online_channel.rb',
              content: File.read(File.expand_path('templates/app/channels/online_channel.rb.erb', __dir__))
            },
            {
              path: 'app/models/concerns/devise_onlineable.rb',
              content: File.read(File.expand_path('templates/app/models/concerns/devise_onlineable.rb.erb', __dir__))
            },
            {
              path: 'app/javascript/channels/consumer.js',
              content: File.read(File.expand_path('templates/app/javascript/channels/consumer.js.erb', __dir__))
            },
            {
              path: 'app/javascript/channels/index.js',
              content: File.read(File.expand_path('templates/app/javascript/channels/index.js.erb', __dir__))
            },
            {
              path: 'app/javascript/channels/online_channel.js',
              content: File.read(File.expand_path('templates/app/javascript/channels/online_channel.js.erb', __dir__))
            }
          ]
        end
      end
    end
  end
end
