require_relative 'enum_definition/presenter'

module WebammToRails
  module Sources
    module Models
      class Enums
        def initialize(table_definition:)
          @table_definition = table_definition
        end

        def collection
          enum_columns.map do |column|
            ::WebammToRails::Sources::Models::EnumDefinition::Presenter.new(column: column).render
          end
        end

        private

        def enum_columns
          @table_definition.columns.select { |col| col.type == 'enum_column' }
        end
      end
    end
  end
end
