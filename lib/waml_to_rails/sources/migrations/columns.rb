require_relative 'column_definition/presenter'

module WamlToRails
  module Sources
    module Migrations
      class Columns
        def initialize(table_definition:)
          @table_definition = table_definition
        end

        def collection
          @table_definition.columns.map do |column|
            ::WamlToRails::Sources::Migrations::ColumnDefinition::Presenter.new(column: column).render
          end
        end
      end
    end
  end
end
