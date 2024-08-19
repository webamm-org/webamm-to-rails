require 'spec_helper'

RSpec.describe WebammToRails::Sources::Migrations::Columns do
  describe '#render' do
    it 'renders columns definitions' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Webamm::Database::Schema::Column.new(
            name: 'first_name',
            type: 'string',
            default: nil,
            null: true
          ),
          Webamm::Database::Schema::Column.new(
            name: 'last_name',
            type: 'string',
            default: nil,
            null: true
          ),
        ]
      )

      waml_definition = Webamm::Definition.new(
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
        't.string :first_name, null: true',
        't.string :last_name, null: true'
      ])
    end

    it 'renders columns definitions with devise' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Webamm::Database::Schema::Column.new(
            name: 'first_name',
            type: 'string',
            default: nil,
            null: true
          ),
          Webamm::Database::Schema::Column.new(
            name: 'last_name',
            type: 'string',
            default: nil,
            null: true
          ),
          Webamm::Database::Schema::Column.new(
            name: 'email',
            type: 'string',
            default: nil,
            null: false
          )
        ]
      )

      waml_definition = Webamm::Definition.new(
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
        't.string :first_name, null: true',
        't.string :last_name, null: true',
        't.string :email, null: false',
        't.string :encrypted_password, null: false',
        't.string :reset_password_token, null: true',
        't.datetime :reset_password_sent_at, null: true',
        't.datetime :remember_created_at, null: true',
        't.integer :sign_in_count, null: false, default: 0',
        't.datetime :current_sign_in_at, null: true',
        't.datetime :last_sign_in_at, null: true',
        't.string :current_sign_in_ip, null: true',
        't.string :last_sign_in_ip, null: true',
        't.string :confirmation_token, null: true',
        't.datetime :confirmed_at, null: true',
        't.datetime :confirmation_sent_at, null: true',
        't.string :unconfirmed_email, null: true'
      ])
    end
  end
end
