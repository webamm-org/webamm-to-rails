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
          @table_definition['table']
        end

        def habtm_table_with_columns?
          @table_definition['columns'].any? && @table_definition['options'].key?('habtm')
        end

        def raw_associations
          @waml_definition['associations'].select { |assoc| assoc['source'] == table_name } | habtm_associations
        end

        def habtm_associations
          return [] unless habtm_table_with_columns?

          table1, table2 = @table_definition['options']['habtm_tables']

          [
            {
              'type' => 'belongs_to',
              'required' => true,
              'source' => table_name,
              'destination' => table1
            },
            {
              'type' => 'belongs_to',
              'required' => true,
              'source' => table_name,
              'destination' => table2
            }
          ]
        end
      end
    end
  end
end
