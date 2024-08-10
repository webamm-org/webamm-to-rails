module WamlToRails
  module Sources
    module Models
      class Associations
        def initialize(table_definition:, waml_definition:)
          @table_definition = table_definition
          @waml_definition = waml_definition
        end

        def collection
          raw_associations.map do |association|
            ::WamlToRails::Sources::Models::AssociationDefinition::Presenter.new(table_definition: @table_definition, association: association).render
          end
        end

        private

        def table_name
          @table_definition.table
        end

        def habtm_table_with_columns?
          @table_definition.columns.any? && @table_definition.options.respond_to?(:habtm)
        end

        def raw_associations
          base_associations = habtm_associations

          @waml_definition.database.relationships.select { |assoc| assoc.source == table_name }.each do |assoc|
            if assoc.type == 'has_many_and_belongs_to_many'
              habtm_table_name = assoc.options.habtm_table
              habtm_table = find_table_definition(habtm_table_name)

              if habtm_table.columns.any?
                base_associations << WamlToRails::Definition::Database::Relationship.new(
                  type: 'has_many',
                  source: table_name,
                  destination: habtm_table_name,
                  required: true
                )

                base_associations << WamlToRails::Definition::Database::Relationship.new(
                  type: 'has_many',
                  source: table_name,
                  destination: assoc.destination,
                  required: true,
                  options: {
                    through: habtm_table_name
                  }
                )
              else
                base_associations << assoc
              end
            elsif assoc.type == 'parent_children'
              base_associations << WamlToRails::Definition::Database::Relationship.new(
                type: 'belongs_to',
                source: table_name,
                destination: 'parent',
                required: false,
                options: {
                  class_name: table_name.classify
                }
              )
             
              base_associations << WamlToRails::Definition::Database::Relationship.new(
                type: 'has_many',
                source: table_name,
                destination: 'children',
                required: true,
                options: {
                  class_name: table_name.classify,
                  foreign_key: 'parent_id',
                  dependent: 'destroy'
                }
              )
            else
              base_associations << assoc
            end
          end

          base_associations
        end

        def habtm_associations
          return [] unless habtm_table_with_columns?

          table1, table2 = @table_definition.options.habtm_tables

          [
            WamlToRails::Definition::Database::Relationship.new(
              type: 'belongs_to',
              required: true,
              source: table_name,
              destination: table1
            ),
            WamlToRails::Definition::Database::Relationship.new(
              type: 'belongs_to',
              required: true,
              source: table_name,
              destination: table2
            )
          ]
        end

        def find_table_definition(table_name)
          @waml_definition.database.schema.find { |table| table.table == table_name }
        end
      end
    end
  end
end
