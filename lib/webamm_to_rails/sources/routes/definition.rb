require_relative 'authentication_definition/presenter'
require_relative 'resource_definition/presenter'

module WebammToRails
  module Sources
    module Routes
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

        def authentication_definition
          ::WebammToRails::Sources::Routes::AuthenticationDefinition::Presenter.new(
            waml_definition: @waml_definition
          ).render
        end

        def resources
          @waml_definition.database.crud.map do |resource|
            ::WebammToRails::Sources::Routes::ResourceDefinition::Presenter.new(
              crud_definition: resource
            ).render
          end
        end
      end
    end
  end
end
