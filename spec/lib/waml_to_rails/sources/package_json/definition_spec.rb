require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::PackageJson::Definition do
  describe '#render' do
    it 'returns default json' do
      waml_definition = ::WamlToRails::Definition.new(
        authentication: [
          {
            table: 'moderators',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq({"name"=>"app", "private"=>true, "devDependencies"=>{"esbuild"=>"^0.23.0"}, "scripts"=>{"build"=>"esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets", "build:css"=>"tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify"}, "dependencies"=>{"@hotwired/stimulus"=>"^3.2.2", "@hotwired/turbo-rails"=>"^8.0.5", "autoprefixer"=>"^10.4.20", "postcss"=>"^8.4.41", "tailwindcss"=>"^3.4.9"}})
    end

    it 'returns default json with actioncable' do
      waml_definition = ::WamlToRails::Definition.new(
        authentication: [
          {
            table: 'moderators',
            features: ['online_indication']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq({"name"=>"app", "private"=>true, "devDependencies"=>{"esbuild"=>"^0.23.0"}, "scripts"=>{"build"=>"esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets", "build:css"=>"tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify"}, "dependencies"=>{"@hotwired/stimulus"=>"^3.2.2", "@hotwired/turbo-rails"=>"^8.0.5", "autoprefixer"=>"^10.4.20", "postcss"=>"^8.4.41", "tailwindcss"=>"^3.4.9", "actioncable"=>"7.1.3"}})
    end
  end
end
