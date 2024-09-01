# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webamm_to_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'webamm_to_rails'
  spec.authors       = ['Paweł Dąbrowski']
  spec.email         = ['contact@paweldabrowski.com']
  spec.license       = 'MIT'
  spec.version       = WebammToRails::VERSION.dup
  spec.summary       = 'Library to convert WEBAMM definition to Ruby on Rails code'
  spec.description   = spec.summary
  spec.files         = Dir['README.md', 'webamm_to_rails.gemspec', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '7.2'
  spec.add_runtime_dependency 'rufo', '0.18.0'
  spec.add_runtime_dependency 'dry-struct', '1.6.0'
  spec.add_runtime_dependency 'webamm', '0.0.2'
  spec.add_runtime_dependency 'htmlbeautifier', '1.4.3'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'

  spec.required_ruby_version = '>= 3.2.2'
end
