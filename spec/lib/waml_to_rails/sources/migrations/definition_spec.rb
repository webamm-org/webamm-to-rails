require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          WamlToRails::Definition::Database::Schema::Column.new(
            name: 'first_name',
            type: 'string',
            null: false,
            default: nil
          )
        ]
      )

      expected_definition = <<~RUBY
        class CreateUsers < ActiveRecord::Migration[7.1]
          def change
            create_table :users do |t|
              t.string :first_name, null: false

              t.timestamps
            end
          end
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition).render
      ).to eq(expected_definition)
    end
  end
end
