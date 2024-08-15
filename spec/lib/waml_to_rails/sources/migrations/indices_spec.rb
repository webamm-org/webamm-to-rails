require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::Indices do
  describe '#render' do
    it 'renders indices definitions' do
      table_definition = Waml::Definition::Database::Schema.new(
        table: 'users',
        indices: [
          Waml::Definition::Database::Schema::Index.new(
            columns: ['first_name', 'last_name'],
            unique: false,
            name: 'index_users_on_first_name_and_last_name'
          ),
          Waml::Definition::Database::Schema::Index.new(
            columns: ['email'],
            unique: true,
            name: 'index_users_on_email'
          )
        ],
        columns: []
      )

      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [table_definition],
          relationships: []
        }
      )

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).collection
      ).to eq([
        'add_index :users, %i[first_name last_name]',
        'add_index :users, :email, unique: true'
      ])
    end

    it 'renders indices definitions with devise' do
      table_definition = Waml::Definition::Database::Schema.new(
        table: 'users',
        indices: [
          Waml::Definition::Database::Schema::Index.new(
            columns: ['first_name', 'last_name'],
            unique: false,
            name: 'index_users_on_first_name_and_last_name'
          ),
          Waml::Definition::Database::Schema::Index.new(
            columns: ['email'],
            unique: true,
            name: 'index_users_on_email'
          )
        ],
        columns: []
      )

      waml_definition = Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [table_definition],
          relationships: []
        }
      )

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).collection
      ).to eq([
        'add_index :users, %i[first_name last_name]',
        'add_index :users, :email, unique: true',
        'add_index :users, :reset_password_token, unique: true',
        'add_index :users, :confirmation_token, unique: true'
      ])
    end
  end
end
