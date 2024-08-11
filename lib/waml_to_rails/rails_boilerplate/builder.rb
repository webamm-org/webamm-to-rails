module WamlToRails
  module RailsBoilerplate
    class Builder
      def self.call
        files = [
          {
            path: '.github/workflows/ci.yml',
            content: File.read(File.expand_path('templates/.github/workflows/ci.yml.erb', __dir__)) 
          },
          {
            path: '.github/dependabot.yml',
            content: File.read(File.expand_path('templates/.github/dependabot.yml.erb', __dir__))
          },
          {
            path: 'app/assets/builds/.keep',
            content: ''
          },
          {
            path: 'app/assets/config/manifest.js',
            content: File.read(File.expand_path('templates/app/assets/config/manifest.js.erb', __dir__))
          },
          {
            path: 'app/assets/images/.keep',
            content: ''
          },
          {
            path: 'app/assets/stylesheets/application.tailwind.css',
            content: File.read(File.expand_path('templates/app/assets/stylesheets/application.tailwind.css.erb', __dir__))
          },
          {
            path: 'app/channels/application_cable/channel.rb',
            content: File.read(File.expand_path('templates/app/channels/application_cable/channel.rb.erb', __dir__))
          },
          {
            path: 'app/channels/application_cable/connection.rb',
            content: File.read(File.expand_path('templates/app/channels/application_cable/connection.rb.erb', __dir__))
          },
          {
            path: 'app/controllers/application_controller.rb',
            content: File.read(File.expand_path('templates/app/controllers/application_controller.rb.erb', __dir__))
          },
          {
            path: 'app/controllers/concerns/.keep',
            content: ''
          },
          {
            path: 'app/helpers/application_helper.rb',
            content: File.read(File.expand_path('templates/app/helpers/application_helper.rb.erb', __dir__))
          },
          {
            path: 'app/javascript/application.js',
            content: File.read(File.expand_path('templates/app/javascript/application.js.erb', __dir__))
          },
          {
            path: 'app/javascript/controllers/index.js',
            content: File.read(File.expand_path('templates/app/javascript/controllers/index.js.erb', __dir__))
          },
          {
            path: 'app/javascript/controllers/application.js',
            content: File.read(File.expand_path('templates/app/javascript/controllers/application.js.erb', __dir__))
          },
          {
            path: 'app/javascript/controllers/hello_controller.js',
            content: File.read(File.expand_path('templates/app/javascript/controllers/hello_controller.js.erb', __dir__))
          },
          {
            path: 'app/jobs/application_job.rb',
            content: File.read(File.expand_path('templates/app/jobs/application_job.rb.erb', __dir__))
          },
          {
            path: 'app/mailers/application_mailer.rb',
            content: File.read(File.expand_path('templates/app/mailers/application_mailer.rb.erb', __dir__))
          },
          {
            path: 'app/models/application_record.rb',
            content: File.read(File.expand_path('templates/app/models/application_record.rb.erb', __dir__))
          },
          {
            path: 'app/models/concerns/.keep',
            content: ''
          },
          {
            path: 'app/models/application_record.rb',
            content: File.read(File.expand_path('templates/app/models/application_record.rb.erb', __dir__))
          },
          {
            path: 'app/views/layouts/application.html.erb',
            content: File.read(File.expand_path('templates/app/views/layouts/application.html.erb', __dir__))
          },
          {
            path: 'app/views/layouts/mailer.html.erb',
            content: File.read(File.expand_path('templates/app/views/layouts/mailer.html.erb', __dir__))
          },
          {
            path: 'app/views/layouts/mailer.text.erb',
            content: File.read(File.expand_path('templates/app/views/layouts/mailer.text.erb', __dir__))
          },
          {
            path: 'app/views/pwa/manifest.json.erb',
            content: File.read(File.expand_path('templates/app/views/pwa/manifest.json.erb', __dir__))
          },
          {
            path: 'app/views/pwa/service-worker.js',
            content: File.read(File.expand_path('templates/app/views/pwa/service-worker.js.erb', __dir__))
          },
          {
            path: 'bin/brakeman',
            content: File.read(File.expand_path('templates/bin/brakeman.erb', __dir__))
          },
          {
            path: 'bin/bundle',
            content: File.read(File.expand_path('templates/bin/bundle.erb', __dir__))
          },
          {
            path: 'bin/dev',
            content: File.read(File.expand_path('templates/bin/dev.erb', __dir__))
          },
          {
            path: 'bin/docker-entrypoint',
            content: File.read(File.expand_path('templates/bin/docker-entrypoint.erb', __dir__))
          },
          {
            path: 'bin/rails',
            content: File.read(File.expand_path('templates/bin/rails.erb', __dir__))
          },
          {
            path: 'bin/rake',
            content: File.read(File.expand_path('templates/bin/rake.erb', __dir__))
          },
          {
            path: 'bin/rubocop',
            content: File.read(File.expand_path('templates/bin/rubocop.erb', __dir__))
          },
          {
            path: 'bin/setup',
            content: File.read(File.expand_path('templates/bin/setup.erb', __dir__))
          },
          {
            path: 'config/environments/development.rb',
            content: File.read(File.expand_path('templates/config/environments/development.rb.erb', __dir__))
          },
          {
            path: 'config/environments/production.rb',
            content: File.read(File.expand_path('templates/config/environments/production.rb.erb', __dir__))
          },
          {
            path: 'config/environments/test.rb',
            content: File.read(File.expand_path('templates/config/environments/test.rb.erb', __dir__))
          },
          {
            path: 'config/initializers/assets.rb',
            content: File.read(File.expand_path('templates/config/initializers/assets.rb.erb', __dir__))
          },
          {
            path: 'config/initializers/content_security_policy.rb',
            content: File.read(File.expand_path('templates/config/initializers/content_security_policy.rb.erb', __dir__))
          },
          {
            path: 'config/initializers/filter_parameter_logging.rb',
            content: File.read(File.expand_path('templates/config/initializers/filter_parameter_logging.rb.erb', __dir__))
          },
          {
            path: 'config/initializers/inflections.rb',
            content: File.read(File.expand_path('templates/config/initializers/inflections.rb.erb', __dir__))
          },
          {
            path: 'config/initializers/permissions_policy.rb',
            content: File.read(File.expand_path('templates/config/initializers/permissions_policy.rb.erb', __dir__))
          },
          {
            path: 'config/locales/en.yml',
            content: File.read(File.expand_path('templates/config/locales/en.yml.erb', __dir__))
          },
          {
            path: 'config/application.rb',
            content: File.read(File.expand_path('templates/config/application.rb.erb', __dir__))
          },
          {
            path: 'config/boot.rb',
            content: File.read(File.expand_path('templates/config/boot.rb.erb', __dir__))
          },
          {
            path: 'config/cable.yml',
            content: File.read(File.expand_path('templates/config/cable.yml.erb', __dir__))
          },
          {
            path: 'config/credentials.yml.enc',
            content: File.read(File.expand_path('templates/config/credentials.yml.enc.erb', __dir__))
          },
          {
            path: 'config/database.yml',
            content: File.read(File.expand_path('templates/config/database.yml.erb', __dir__))
          },
          {
            path: 'config/environment.rb',
            content: File.read(File.expand_path('templates/config/environment.rb.erb', __dir__))
          },
          {
            path: 'config/master.key',
            content: File.read(File.expand_path('templates/config/master.key.erb', __dir__))
          },
          {
            path: 'config/puma.rb',
            content: File.read(File.expand_path('templates/config/puma.rb.erb', __dir__))
          },
          {
            path: 'config/routes.rb',
            content: File.read(File.expand_path('templates/config/routes.rb.erb', __dir__))
          },
          {
            path: 'config/storage.yml',
            content: File.read(File.expand_path('templates/config/storage.yml.erb', __dir__))
          },
          {
            path: 'db/seeds.rb',
            content: File.read(File.expand_path('templates/db/seeds.rb.erb', __dir__))
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
            content: File.read(File.expand_path('templates/public/404.html.erb', __dir__))
          },
          {
            path: 'public/406-unsupported-browser.html',
            content: File.read(File.expand_path('templates/public/406-unsupported-browser.html.erb', __dir__))
          },
          {
            path: 'public/422.html',
            content: File.read(File.expand_path('templates/public/422.html.erb', __dir__))
          },
          {
            path: 'public/500.html',
            content: File.read(File.expand_path('templates/public/500.html.erb', __dir__))
          },
          # {
          #   path: 'public/icon.png',
          #   content: File.read(File.expand_path('templates/public/icon.png.erb', __dir__))
          # },
          # {
          #   path: 'public/icon.svg',
          #   content: File.read(File.expand_path('templates/public/icon.svg.erb', __dir__))
          # },
          {
            path: 'public/robots.txt',
            content: File.read(File.expand_path('templates/public/robots.txt.erb', __dir__))
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
            content: File.read(File.expand_path('templates/dockerignore.erb', __dir__))
          },
          {
            path: '.gitattributes',
            content: File.read(File.expand_path('templates/gitattributes.erb', __dir__))
          },
          {
            path: '.gitignore',
            content: File.read(File.expand_path('templates/gitignore.erb', __dir__))
          },
          {
            path: '.node-version',
            content: File.read(File.expand_path('templates/node-version.erb', __dir__))
          },
          {
            path: '.rubocop.yml',
            content: File.read(File.expand_path('templates/rubocop.yml.erb', __dir__))
          },
          {
            path: '.ruby-version',
            content: File.read(File.expand_path('templates/ruby-version.erb', __dir__))
          },
          {
            path: 'config.ru',
            content: File.read(File.expand_path('templates/config.ru.erb', __dir__))
          },
          {
            path: 'Dockerfile',
            content: File.read(File.expand_path('templates/Dockerfile.erb', __dir__))
          },
          {
            path: 'Gemfile',
            content: File.read(File.expand_path('templates/Gemfile.erb', __dir__))
          },
          {
            path: 'package.json',
            content: File.read(File.expand_path('templates/package.json.erb', __dir__))
          },
          {
            path: 'Procfile.dev',
            content: File.read(File.expand_path('templates/Procfile.dev.erb', __dir__))
          },
          {
            path: 'Rakefile',
            content: File.read(File.expand_path('templates/Rakefile.erb', __dir__))
          },
          {
            path: 'README.md',
            content: File.read(File.expand_path('templates/README.md.erb', __dir__))
          },
          {
            path: 'tailwind.config.js',
            content: File.read(File.expand_path('templates/tailwind.config.js.erb', __dir__))
          }
        ]
      end
    end
  end
end
