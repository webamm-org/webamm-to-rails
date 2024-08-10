require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::Indices do
  describe '#render' do
    it 'renders indices definitions' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [
          WamlToRails::Definition::Database::Schema::Index.new(
            columns: ['first_name', 'last_name'],
            unique: false,
            name: 'index_users_on_first_name_and_last_name'
          ),
          WamlToRails::Definition::Database::Schema::Index.new(
            columns: ['email'],
            unique: true,
            name: 'index_users_on_email'
          )
        ],
        columns: []
      )

      expect(
        described_class.new(table_definition: table_definition).collection
      ).to eq([
        'add_index :users, %i[first_name last_name]',
        'add_index :users, :email, unique: true'
      ])
    end
  end
end
