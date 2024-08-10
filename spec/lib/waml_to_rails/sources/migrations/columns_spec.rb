require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::Columns do
  describe '#render' do
    it 'renders columns definitions' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          WamlToRails::Definition::Database::Schema::Column.new(
            name: 'first_name',
            type: 'string',
            default: nil,
            null: true
          ),
          WamlToRails::Definition::Database::Schema::Column.new(
            name: 'last_name',
            type: 'string',
            default: nil,
            null: true
          ),
        ]
      )

      expect(
        described_class.new(table_definition: table_definition).collection
      ).to eq([
        't.string :first_name, null: true',
        't.string :last_name, null: true'
      ])
    end
  end
end
