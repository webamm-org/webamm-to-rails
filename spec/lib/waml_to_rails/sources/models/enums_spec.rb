require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Enums do
  describe '#collection' do
    it 'returns collection of enum definitions' do
      schema = Waml::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Waml::Definition::Database::Schema::Column.new(
            name: 'status', type: 'enum_column', values: ['accepted', 'rejected'], default: nil, null: false
          ),
          Waml::Definition::Database::Schema::Column.new(
            name: 'role', type: 'enum_column', values: ['admin', 'user'], default: 'user', null: false
          )
        ]
      )

      enums = described_class.new(table_definition: schema).collection

      expect(enums).to eq([
        'enum :status, { accepted: 0, rejected: 1 }',
        'enum :role, { admin: 0, user: 1 }, default: :user'
      ])
    end
  end
end
