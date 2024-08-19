require_relative 'index_definition/presenter'
require_relative 'devise/definition'

module WebammToRails
  module Sources
    module Migrations
      class Indices
        def initialize(waml_definition:, table_definition:)
          @waml_definition = waml_definition
          @table_definition = table_definition
        end

        def collection
          indices.uniq(&:columns).map do |index|
            ::WebammToRails::Sources::Migrations::IndexDefinition::Presenter.new(table_name: @table_definition.table, index: index).render
          end
        end

        private

        def indices
          @table_definition.indices + devise_indices
        end

        def devise_indices
          ::WebammToRails::Sources::Migrations::Devise::Definition.new(
            waml_definition: @waml_definition, table_name: @table_definition.table
          ).indices_collection
        end
      end
    end
  end
end
