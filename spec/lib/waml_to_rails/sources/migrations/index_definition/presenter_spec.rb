require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::IndexDefinition::Presenter do
  describe '#render' do
    it 'renders index definition for single column' do
      table_name = 'users'
      index = WamlToRails::Definition::Database::Schema::Index.new(
        columns: ['first_name'],
        unique: false,
        name: 'index_users_on_first_name'
      )

      expect(
        described_class.new(table_name: table_name, index: index).render
      ).to eq('add_index :users, :first_name')
    end

    it 'renders index definition for multiple columns' do
      table_name = 'users'
      index = WamlToRails::Definition::Database::Schema::Index.new(
        columns: ['first_name', 'last_name'],
        unique: false,
        name: 'index_users_on_first_name_and_last_name'
      )

      expect(
        described_class.new(table_name: table_name, index: index).render
      ).to eq('add_index :users, %i[first_name last_name]')
    end

    it 'renders index for single column with unique option' do
      table_name = 'users'
      index = WamlToRails::Definition::Database::Schema::Index.new(
        columns: ['first_name'],
        unique: true,
        name: 'index_users_on_first_name'
      )

      expect(
        described_class.new(table_name: table_name, index: index).render
      ).to eq('add_index :users, :first_name, unique: true')
    end

    it 'renders index for multiple columns with unique option' do
      table_name = 'users'
      index = WamlToRails::Definition::Database::Schema::Index.new(
        columns: ['first_name', 'last_name'],
        unique: true,
        name: 'index_users_on_first_name_and_last_name'
      )

      expect(
        described_class.new(table_name: table_name, index: index).render
      ).to eq('add_index :users, %i[first_name last_name], unique: true')
    end
  end
end
