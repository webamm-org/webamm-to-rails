require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Concerns do
  describe '#collection' do
    it 'returns nothing if there are no authentications' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: []
      )

      waml_definition = WamlToRails::Definition.new(
        database: {
          engine: 'postgresql',
          schema: [table_definition],
          relationships: []
        },
        authentication: []
      )

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns nothing if online indication is not enabled' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: []
      )

      waml_definition = WamlToRails::Definition.new(
        database: {
          engine: 'postgresql',
          schema: [table_definition],
          relationships: []
        },
        authentication: [
          {
            table: 'users',
            features: []
          }
        ]
      )

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns definition if online indication is enabled' do
      table_definition = WamlToRails::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: []
      )

      waml_definition = WamlToRails::Definition.new(
        database: {
          engine: 'postgresql',
          schema: [table_definition],
          relationships: []
        },
        authentication: [
          {
            table: 'users',
            features: ['online_indication']
          }
        ]
      )

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).collection
      ).to eq(['include DeviseOnlineable'])
    end
  end
end
