require_relative '../../application_controller/authentication/devise_groups/presenter'

module WebammToRails
  module Sources
    module Controllers
      module Filters
        module DeviseDefinition
          class Presenter
            def initialize(crud_definition:, waml_definition:)
              @crud_definition = crud_definition
              @waml_definition = waml_definition
            end

            def collection
              base_collection = []
              action_mappings = {}

              @crud_definition.actions.each do |action|
                next if action.options.authentication.blank?

                action_mappings[action.options.authentication] ||= []
                action_mappings[action.options.authentication] << action.name

                if action.name == 'create'
                  action_mappings[action.options.authentication] << 'new'
                end

                if action.name == 'update'
                  action_mappings[action.options.authentication] << 'edit'
                end
              end

              action_mappings.each_pair do |group, actions|
                devise_resource = mappings[group]

                actions_def = actions.map { |action| ":#{action}" }.join(', ')
                base_collection << "before_action :authenticate_#{devise_resource.singularize}!, only: [#{actions_def}]"
              end

              base_collection
            end

            private

            def mappings
              @mappings ||= ::WebammToRails::Sources::Controllers::ApplicationController::Authentication::DeviseGroups::Presenter.new(
                waml_definition: @waml_definition
              ).mappings
            end
          end
        end
      end
    end
  end
end
