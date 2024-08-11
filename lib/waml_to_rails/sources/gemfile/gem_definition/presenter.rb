module WamlToRails
  module Sources
    module Gemfile
      module GemDefinition
        class Presenter
          def initialize(gem:)
            @gem = gem
          end

          def render
            base_definition = "gem '#{@gem.name}'"
            base_definition += ", '#{@gem.version}'" if @gem.version.present?
            base_definition += ", require: false" unless @gem.required
            base_definition += ", platforms: %i[#{@gem.platforms.map { |val| "#{val}" }.join(' ')}]" if @gem.platforms.present?

            [@gem.group, base_definition]
          end
        end
      end
    end
  end
end
