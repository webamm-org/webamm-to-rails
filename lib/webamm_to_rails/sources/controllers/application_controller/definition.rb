require_relative 'authentication/devise_groups/presenter'
require_relative 'authentication/devise_groups_definition/presenter'

module WebammToRails
  module Sources
    module Controllers
      module ApplicationController
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

          def devise_groups
            devise_mappings = ::WebammToRails::Sources::Controllers::ApplicationController::Authentication::DeviseGroups::Presenter.new(
              waml_definition: @waml_definition
            ).mappings

            ::WebammToRails::Sources::Controllers::ApplicationController::Authentication::DeviseGroupsDefinition::Presenter.new(
              devise_mappings: devise_mappings
            ).collection
          end
        end
      end
    end
  end
end
