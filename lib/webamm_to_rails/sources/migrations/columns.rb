require_relative 'column_definition/presenter'
require_relative 'devise/definition'

module WebammToRails
  module Sources
    module Migrations
      class Columns
        def initialize(waml_definition:, table_definition:)
          @waml_definition = waml_definition
          @table_definition = table_definition
        end

        def collection
          columns.compact.uniq(&:name).map do |column|
            ::WebammToRails::Sources::Migrations::ColumnDefinition::Presenter.new(column: column).render
          end
        end

        private

        def columns
          @table_definition.columns + devise_columns
        end

        def devise_columns
          ::WebammToRails::Sources::Migrations::Devise::Definition.new(
            waml_definition: @waml_definition, table_name: @table_definition.table
          ).columns_collection
        end
      end
    end
  end
end
