require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::AssociationDefinition::Presenter do
  describe '#render' do
    context 'when association is belongs_to' do
      it 'returns the association definition when association is optional' do
        table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
        association = WamlToRails::Definition::Database::Relationship.new(type: 'belongs_to', required: false, destination: 'companies', source: 'users')

        expect(
          described_class.new(table_definition: table_definition, association: association).render
        ).to eq('belongs_to :company, optional: true')
      end

      it 'returns the association definition when association is required' do
        table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
        association = WamlToRails::Definition::Database::Relationship.new(type: 'belongs_to', required: true, destination: 'companies', source: 'users')

        expect(
          described_class.new(table_definition: table_definition, association: association).render
        ).to eq('belongs_to :company')
      end
    end

    it 'renders has_one association' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      association = WamlToRails::Definition::Database::Relationship.new(type: 'has_one', destination: 'companies', source: 'users', required: true)

      expect(
        described_class.new(table_definition: table_definition, association: association).render
      ).to eq('has_one :company')
    end

    it 'renders has_many association' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      association = WamlToRails::Definition::Database::Relationship.new(type: 'has_many', destination: 'companies', source: 'users', required: false)

      expect(
        described_class.new(table_definition: table_definition, association: association).render
      ).to eq('has_many :companies')
    end

    it 'renders has_many association with through' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      association = WamlToRails::Definition::Database::Relationship.new(type: 'has_many', destination: 'companies', source: 'users', required: false, options: { through: 'user_companies' })

      expect(
        described_class.new(table_definition: table_definition, association: association).render
      ).to eq('has_many :companies, through: :user_companies')
    end

    it 'renders has_many_and_belongs_to_many association' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      association = WamlToRails::Definition::Database::Relationship.new(type: 'has_many_and_belongs_to_many', destination: 'companies', source: 'users', required: false)

      expect(
        described_class.new(table_definition: table_definition, association: association).render
      ).to eq('has_and_belongs_to_many :companies')
    end

    it 'raises error when association type is unknown' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      association = WamlToRails::Definition::Database::Relationship.new(type: 'unknown', destination: 'companies', source: 'users', required: false)

      expect {
        described_class.new(table_definition: table_definition, association: association).render
      }.to raise_error(WamlToRails::Sources::Models::AssociationDefinition::Presenter::UnknownAssociationType)
    end
  end
end
