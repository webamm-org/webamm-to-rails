require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Gemfile::Definition do
  describe '#render' do
    it 'renders the gemfile' do
      waml_definition = waml_definition = Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expected_definition = <<~RUBY
        source "https://rubygems.org"

        gem "rails", "7.1.0"
        gem "sprockets-rails"
        gem "pg", "~> 1.1"
        gem "puma", ">= 5.0"
        gem "jsbundling-rails"
        gem "turbo-rails"
        gem "stimulus-rails"
        gem "cssbundling-rails"
        gem "jbuilder"
        gem "redis", ">= 4.0.1"
        gem "tzinfo-data", platforms: %i[windows jruby]
        gem "bootsnap", require: false
        gem "devise", "4.9.4"
        gem "devise_invitable", "2.0.9"

        group :development do
          gem "web-console", require: false
        end

        group :development, :test do
          gem "debug", require: false, platforms: %i[mri windows]
          gem "brakeman", require: false
          gem "rubocop-rails-omakase", require: false
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
