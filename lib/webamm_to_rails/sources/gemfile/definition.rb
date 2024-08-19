require_relative 'gem'
require_relative 'project_set'
require_relative 'gem_definition/presenter'

module WebammToRails
  module Sources
    module Gemfile
      class Definition
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          ::WebammToRails::Utils::FormatCode.call(raw_content)
        end

        private

        def gems
          ::WebammToRails::Sources::Gemfile::ProjectSet.new(waml_definition: @waml_definition).collection.map do |gem|
            ::WebammToRails::Sources::Gemfile::GemDefinition::Presenter.new(gem: gem).render
          end.inject({}) { |hash, gem| hash[gem.first] ||= []; hash[gem.first] << gem.last; hash }
        end
      end
    end
  end
end
