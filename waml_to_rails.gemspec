# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'waml_to_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'waml_to_rails'
  spec.authors       = ['Paweł Dąbrowski']
  spec.email         = ['contact@paweldabrowski.com']
  spec.license       = 'MIT'
  spec.version       = WamlToRails::VERSION.dup
  spec.summary       = 'Library to convert WAML (Web Application Markup Language) definition to Ruby on Rails code'
  spec.description   = spec.summary
  spec.files         = Dir['README.md', 'waml_to_rails.gemspec', 'lib/**/*']
  spec.require_paths = ['lib']
  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.pkg.github.com/waml_to_rails'
  }

  spec.required_ruby_version = '>= 3.2.2'
end
