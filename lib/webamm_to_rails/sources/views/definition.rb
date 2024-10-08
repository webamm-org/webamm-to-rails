require_relative 'devise/presenter'
require_relative 'resource/presenter'

module WebammToRails
  module Sources
    module Views
      class Definition
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          views = []
          views |= ::WebammToRails::Sources::Views::Devise::Presenter.new(waml_definition: @waml_definition).collection

          @waml_definition.database.crud.each do |crud_definition|
            views |= ::WebammToRails::Sources::Views::Resource::Presenter.new(
              crud_definition: crud_definition,
              waml_definition: @waml_definition
            ).collection
          end

          views
        end
      end
    end
  end
end
