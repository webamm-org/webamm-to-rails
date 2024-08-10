require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::TableDefinition::Presenter do
  describe '#render' do
    it 'renders the table definition' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'plans', indices: [], columns: [],
      )

      expect(
        described_class.new(table_definition: table_definition).render
      ).to eq('create_table :plans do |t|')
    end

    it 'renders the table definition with id: :uuid' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'plans', indices: [], columns: [], options: { use_uuid: true }
      )

      expect(
        described_class.new(table_definition: table_definition).render
      ).to eq('create_table :plans, id: :uuid do |t|')
    end
  end
end
