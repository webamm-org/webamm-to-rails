require_relative 'index_definition/presenter'
require_relative 'edit_definition/presenter'
require_relative 'new_definition/presenter'
require_relative 'show_definition/presenter'
require_relative 'form_definition/presenter'

module WebammToRails
  module Sources
    module Views
      module Resource
        class Presenter
          def initialize(crud_definition:, waml_definition:)
            @crud_definition = crud_definition
            @waml_definition = waml_definition
          end

          def collection
            views.select(&:render?).map do |view|
              {
                path: view.path_name,
                content: view.render
              }
            end
          end

          private

          def views
            [
              ::WebammToRails::Sources::Views::Resource::IndexDefinition::Presenter.new(crud_definition: @crud_definition),
              ::WebammToRails::Sources::Views::Resource::EditDefinition::Presenter.new(crud_definition: @crud_definition),
              ::WebammToRails::Sources::Views::Resource::NewDefinition::Presenter.new(crud_definition: @crud_definition),
              ::WebammToRails::Sources::Views::Resource::ShowDefinition::Presenter.new(crud_definition: @crud_definition),
              ::WebammToRails::Sources::Views::Resource::FormDefinition::Presenter.new(crud_definition: @crud_definition, waml_definition: @waml_definition),
            ]
          end
        end
      end
    end
  end
end
