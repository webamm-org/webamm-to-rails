require 'spec_helper'

RSpec.describe WebammToRails::Sources::Migrations::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [
          Webamm::Database::Schema::Index.new(
            columns: ['first_name'],
            unique: false,
            name: 'index_users_on_first_name'
          )
        ],
        columns: [
          Webamm::Database::Schema::Column.new(
            name: 'first_name',
            type: 'string',
            null: false,
            default: nil
          )
        ]
      )

      waml_definition = Webamm::Definition.new(
        database: {
          schema: [
            table_definition,
            Webamm::Definition::Database::Schema.new(
              table: 'companies',
              indices: [],
              columns: [],
              options: {}
            )
          ],
          engine: 'postgresql',
          relationships: [
            Webamm::Database::Relationship.new(
              type: 'belongs_to',
              source: 'users',
              destination: 'companies',
              required: false
            )
          ]
        }
      )

      expected_definition = <<~RUBY
        class CreateUsers < ActiveRecord::Migration[7.1]
          def change
            create_table :users do |t|
              t.string :first_name, null: false
              t.references :companies, foreign_key: true, null: true

              t.timestamps
            end

            add_index :users, :first_name
          end
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
