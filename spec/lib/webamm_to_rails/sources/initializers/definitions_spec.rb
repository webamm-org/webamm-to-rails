require 'spec_helper'

RSpec.describe WebammToRails::Sources::Initializers::Definitions do
  describe '#collection' do
    it 'returns a collection of initializers' do
      waml_definition = Webamm::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      collection = described_class.new(waml_definition: waml_definition).collection

      expect(collection).to eq([])
    end

    it 'returns a collection of initializers with authentication' do
      waml_definition = Webamm::Definition.new(
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

      collection = described_class.new(waml_definition: waml_definition).collection

      expect(collection.size).to eq(1)
      expect(collection.first[:path]).to eq('config/initializers/devise.rb')
    end
  end
end
