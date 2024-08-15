require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Migrations::Devise::Definition do
  describe '#columns_collection' do
    it 'returns empty collection when authentication is not enabled' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).columns_collection
      ).to eq([])
    end

    it 'returns default collection when authentication is enabled' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      columns = described_class.new(table_name: 'users', waml_definition: waml_definition).columns_collection

      expect(columns.size).to eq(14)
      expect(columns.first.name).to eq('email')
    end

    it 'returns default collection when authentication is enabled and invitations' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      columns = described_class.new(table_name: 'users', waml_definition: waml_definition).columns_collection

      expect(columns.size).to eq(21)
    end

    it 'returns default collection when authentication is enabled and two factor authentication' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['two_factor_authentication']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      columns = described_class.new(table_name: 'users', waml_definition: waml_definition).columns_collection

      expect(columns.size).to eq(24)
    end
  end

  describe '#indices_collection' do
    it 'returns empty collection when authentication is not enabled' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).indices_collection
      ).to eq([])
    end

    it 'returns default collection when authentication is enabled' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      indices = described_class.new(table_name: 'users', waml_definition: waml_definition).indices_collection

      expect(indices.size).to eq(3)
      expect(indices.first.name).to eq('email_idx')
    end

    it 'returns default collection when authentication is enabled and invitations' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      indices = described_class.new(table_name: 'users', waml_definition: waml_definition).indices_collection

      expect(indices.size).to eq(4)
    end

    it 'returns default collection when authentication is enabled and two factor authentication' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['two_factor_authentication']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      indices = described_class.new(table_name: 'users', waml_definition: waml_definition).indices_collection

      expect(indices.size).to eq(5)
    end
  end
end
