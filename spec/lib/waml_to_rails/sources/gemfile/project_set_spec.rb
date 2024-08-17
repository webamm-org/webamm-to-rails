require 'spec_helper'

RSpec.describe WamlToRails::Sources::Gemfile::ProjectSet do
  describe '#collection' do
    it 'returns combined set of gems' do
      waml_definition = Waml::Definition.new(
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

      gems = described_class.new(waml_definition: waml_definition).collection

      expect(gems.size).to eq(19)
    end
  end
end
