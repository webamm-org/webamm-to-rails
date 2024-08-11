module WamlToRails
  module Sources
    module Gemfile
      class DefaultSet
        GEMS = [
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "rails", version: "~> 7.2.0", required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "sprockets-rails", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "pg", version: "~> 1.1", required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "puma", version: ">= 5.0", required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "jsbundling-rails", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "turbo-rails", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "stimulus-rails", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "cssbundling-rails", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "jbuilder", version: nil, required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "redis", version: ">= 4.0.1", required: true, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "tzinfo-data", version: nil, required: true, group: :default, platforms: %i[ windows jruby ]),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "bootsnap", version: nil, required: false, group: :default, platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "debug", version: nil, required: false, group: %i[development test], platforms: %i[ mri windows ]),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "brakeman", version: nil, required: false, group: %i[development test], platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "rubocop-rails-omakase", version: nil, required: false, group: %i[development test], platforms: []),
          ::WamlToRails::Sources::Gemfile::Gem.new(name: "web-console", version: nil, required: false, group: :development, platforms: []),
        ]
      end
    end
  end
end
