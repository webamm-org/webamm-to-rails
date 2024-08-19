module WebammToRails
  module Sources
    module Migrations
      class Associations
        def initialize(table_definition:, waml_definition:)
          @table_definition = table_definition
          @waml_definition = waml_definition
        end

        def collection
          base_associations = associations.map do |assoc|
            if assoc.type == 'belongs_to'
              relation_table_definition = find_table_definition(assoc.destination)
              assoc_def = "t.references :#{assoc.destination}, foreign_key: true, null: #{!assoc.required}"
              assoc_def += ", type: :uuid" if relation_table_definition.options&.use_uuid
              assoc_def
            elsif assoc.type == 'parent_children'
              assoc_def = "t.references :parent, foreign_key: { to_table: :#{@table_definition.table} }, null: true"
              assoc_def += ", type: :uuid" if @table_definition.options&.use_uuid
              assoc_def
            end
          end

          return base_associations unless @table_definition.options&.habtm

          habtm_tables = @table_definition.options.habtm_tables

          base_associations << "t.belongs_to :#{habtm_tables.first}"
          base_associations << "t.belongs_to :#{habtm_tables.second}"

          base_associations
        end

        private

        def associations
          @waml_definition.database.relationships.select do |relationship|
            (relationship.type == 'belongs_to' || relationship.type == 'parent_children') &&
              relationship.source == @table_definition.table
          end
        end

        def find_table_definition(table_name)
          @waml_definition.database.schema.find { |table| table.table == table_name }
        end
      end
    end
  end
end
