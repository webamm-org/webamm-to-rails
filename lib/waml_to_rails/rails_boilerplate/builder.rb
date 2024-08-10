module WamlToRails
  module RailsBoilerplate
    class Builder
      def self.call
        files = [
          {
            path: '.github/workflows/ci.yml',
            content: '' 
          },
          {
            path: '.github/dependabot.yml',
            content: ''
          },
          {
            path: 'app/assets/builds/.keep',
            content: ''
          },
          {
            path: 'app/assets/config/manifest.js',
            content: ''
          },
          {
            path: 'app/assets/images/.keep',
            content: ''
          },
          {
            path: 'app/assets/stylesheets/application.tailwind.css',
            content: ''
          },
          {
            path: 'app/channels/application_cable/channel.rb',
            content: ''
          },
          {
            path: 'app/channels/application_cable/connection.rb',
            content: ''
          },
          {
            path: 'app/controllers/application_controller.rb',
            content: ''
          },
          {
            path: 'app/controllers/concerns/.keep',
            content: ''
          },
          {
            path: 'app/helpers/application_helper.rb',
            content: ''
          },
          {
            path: 'app/javascript/application.js',
            content: ''
          },
          {
            path: 'app/javascript/controllers/index.js',
            content: ''
          },
          {
            path: 'app/javascript/controllers/application.js',
            content: ''
          },
          {
            path: 'app/javascript/controllers/hello_controller.js',
            content: ''
          },
          {
            path: 'app/jobs/application_job.rb',
            content: ''
          },
          {
            path: 'app/mailers/application_mailer.rb',
            content: ''
          },
          {
            path: 'app/models/application_record.rb',
            content: ''
          },
          {
            path: 'app/models/concerns/.keep',
            content: ''
          },
          {
            path: 'app/models/application_record.rb',
            content: ''
          },
          {
            path: 'app/views/layouts/application.html.erb',
            content: ''
          },
          {
            path: 'app/views/layouts/mailer.html.erb',
            content: ''
          },
          {
            path: 'app/views/layouts/mailer.text.erb',
            content: ''
          },
          {
            path: 'app/views/pwa/manifest.json.erb',
            content: ''
          },
          {
            path: 'app/views/pwa/service_worker.js',
            content: ''
          },
          {
            path: 'bin/brakeman',
            content: ''
          },
          {
            path: 'bin/bundle',
            content: ''
          },
          {
            path: 'bin/dev',
            content: ''
          },
          {
            path: 'bin/docker-entrypoint',
            content: ''
          },
          {
            path: 'bin/rails',
            content: ''
          },
          {
            path: 'bin/rake',
            content: ''
          },
          {
            path: 'bin/rubocop',
            content: ''
          },
          {
            path: 'bin/setup',
            content: ''
          },
          {
            path: 'config/environments/development.rb',
            content: ''
          },
          {
            path: 'config/environments/production.rb',
            content: ''
          },
          {
            path: 'config/environments/test.rb',
            content: ''
          },
          {
            path: 'config/initializers/assets.rb',
            content: ''
          },
          {
            path: 'config/initializers/content_security_policy.rb',
            content: ''
          },
          {
            path: 'config/initializers/filter_parameter_logging.rb',
            content: ''
          },
          {
            path: 'config/initializers/inflections.rb',
            content: ''
          },
          {
            path: 'config/initializers/permissions_policy.rb',
            content: ''
          },
          {
            path: 'config/locales/en.yml',
            content: ''
          },
          {
            path: 'config/application.rb',
            content: ''
          },
          {
            path: 'config/boot.rb',
            content: ''
          },
          {
            path: 'config/cable.yml',
            content: ''
          },
          {
            path: 'config/credentials.yml.enc',
            content: ''
          },
          {
            path: 'config/database.yml',
            content: ''
          },
          {
            path: 'config/environment.rb',
            content: ''
          },
          {
            path: 'config/master.key',
            content: ''
          },
          {
            path: 'config/puma.rb',
            content: ''
          },
          {
            path: 'config/routes.rb',
            content: ''
          },
          {
            path: 'config/storage.yml',
            content: ''
          },
          {
            path: 'db/seeds.rb',
            content: ''
          },
          {
            path: 'lib/assets/.keep',
            content: ''
          },
          {
            path: 'lib/tasks/.keep',
            content: ''
          },
          {
            path: 'log/.keep',
            content: ''
          },
          {
            path: 'log/development.log',
            content: ''
          },
          {
            path: 'public/404.html',
            content: ''
          },
          {
            path: 'public/406-unsupported-browser.html',
            content: ''
          },
          {
            path: 'public/422.html',
            content: ''
          },
          {
            path: 'public/500.html',
            content: ''
          },
          {
            path: 'public/icon.png',
            content: ''
          },
          {
            path: 'public/icon.svg',
            content: ''
          },
          {
            path: 'public/robots.txt',
            content: ''
          },
          {
            path: 'storage/.keep',
            content: ''
          },
          {
            path: 'tmp/.keep',
            content: ''
          },
          {
            path: 'vendor/.keep',
            content: ''
          },
          {
            path: '.dockerignore',
            content: ''
          },
          {
            path: '.gitattributes',
            content: ''
          },
          {
            path: '.gitignore',
            content: ''
          },
          {
            path: '.node-version',
            content: ''
          },
          {
            path: '.rubocop.yml',
            content: ''
          },
          {
            path: '.ruby-version',
            content: ''
          },
          {
            path: 'config.ru',
            content: ''
          },
          {
            path: 'Dockerfile',
            content: ''
          },
          {
            path: 'Gemfile',
            content: ''
          },
          {
            path: 'package.json',
            content: ''
          },
          {
            path: 'Procfile.dev',
            content: ''
          },
          {
            path: 'Rakefile',
            content: ''
          },
          {
            path: 'README.md',
            content: ''
          },
          {
            path: 'tailwind.config.js',
            content: ''
          }
        ]
      end
    end
  end
end
