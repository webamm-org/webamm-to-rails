require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Migrations::Associations do
  describe '#collection' do
    context 'habtm association' do
      it 'returns collection for habtm association' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'companies_employees',
          indices: [],
          columns: [],
          options: {
            habtm: true,
            habtm_tables: ['companies', 'employees']
          }
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
            ],
            engine: 'postgresql',
            relationships: []
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq([
          't.belongs_to :companies',
          't.belongs_to :employees'
        ])
      end
    end

    context 'parent children association' do
      it 'returns collection for parent children association' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'categories',
          indices: [],
          columns: [],
          options: {}
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
            ],
            engine: 'postgresql',
            relationships: [
              ::Waml::Definition::Database::Relationship.new(
                source: 'categories',
                required: false,
                type: 'parent_children'
              )
            ]
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq(
          [
            't.references :parent, foreign_key: { to_table: :categories }, null: true'
          ]
        )
      end

      it 'returns collection for parent children association with uuid' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'categories',
          indices: [],
          columns: [],
          options: {
            use_uuid: true
          }
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
            ],
            engine: 'postgresql',
            relationships: [
              ::Waml::Definition::Database::Relationship.new(
                source: 'categories',
                required: false,
                type: 'parent_children'
              )
            ]
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq(
          [
            't.references :parent, foreign_key: { to_table: :categories }, null: true, type: :uuid'
          ]
        )
      end
    end

    context 'belongs_to association' do
      it 'returns collection for belongs_to association that is not required' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'employees',
          indices: [],
          columns: [],
          options: {}
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
              ::Waml::Definition::Database::Schema.new(
                table: 'companies',
                indices: [],
                columns: [],
                options: {}
              )
            ],
            engine: 'postgresql',
            relationships: [
              ::Waml::Definition::Database::Relationship.new(
                source: 'employees',
                destination: 'companies',
                required: false,
                type: 'belongs_to'
              )
            ]
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq(
          [
            't.references :companies, foreign_key: true, null: true'
          ]
        )
      end

      it 'returns collection for belongs_to association that is required' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'employees',
          indices: [],
          columns: [],
          options: {}
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
              ::Waml::Definition::Database::Schema.new(
                table: 'companies',
                indices: [],
                columns: [],
                options: {}
              )
            ],
            engine: 'postgresql',
            relationships: [
              ::Waml::Definition::Database::Relationship.new(
                source: 'employees',
                destination: 'companies',
                required: true,
                type: 'belongs_to'
              )
            ]
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq(
          [
            't.references :companies, foreign_key: true, null: false'
          ]
        )
      end

      it 'returns collection for belongs_to association where destination uses uuid' do
        table_definition = ::Waml::Definition::Database::Schema.new(
          table: 'employees',
          indices: [],
          columns: [],
          options: {}
        )

        waml_definition = ::Waml::Definition.new(
          database: {
            schema: [
              table_definition,
              ::Waml::Definition::Database::Schema.new(
                table: 'companies',
                indices: [],
                columns: [],
                options: {
                  use_uuid: true
                }
              )
            ],
            engine: 'postgresql',
            relationships: [
              ::Waml::Definition::Database::Relationship.new(
                source: 'employees',
                destination: 'companies',
                required: false,
                type: 'belongs_to'
              )
            ]
          }
        )

        expect(
          described_class.new(
            table_definition: table_definition,
            waml_definition: waml_definition
          ).collection
        ).to eq(
          [
            't.references :companies, foreign_key: true, null: true, type: :uuid'
          ]
        )
      end
    end
  end
end
