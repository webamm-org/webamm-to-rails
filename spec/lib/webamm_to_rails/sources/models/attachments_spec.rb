require 'spec_helper'

RSpec.describe WebammToRails::Sources::Models::Attachments do
  describe '#collection' do
    it 'returns attachment definitions' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Webamm::Database::Schema::Column.new(name: 'avatar', type: 'file', default: nil, null: false),
          Webamm::Database::Schema::Column.new(name: 'photos', type: 'file', default: nil, null: false),
          Webamm::Database::Schema::Column.new(name: 'first_name', type: 'string', default: nil, null: false),
          Webamm::Database::Schema::Column.new(name: 'last_name', type: 'string', default: nil, null: false)
        ]
      )

      expect(
        described_class.new(table_definition: table_definition).collection
      ).to eq([
        'has_one_attached :avatar',
        'has_many_attached :photos'
      ])
    end
  end
end
