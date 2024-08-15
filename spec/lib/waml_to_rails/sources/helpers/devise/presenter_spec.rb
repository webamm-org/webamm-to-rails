require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Helpers::Devise::Presenter do
  describe '#collection' do
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
        described_class.new(waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns empty collection when two_factor_authentication is not enabled' do
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

      expect(
        described_class.new(waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns collection when two_factor_authentication is enabled' do
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

      helpers = described_class.new(waml_definition: waml_definition).collection

      expect(helpers.size).to eq(1)
      expect(helpers.first[:path]).to eq('app/helpers/devise_qr_code_helper.rb')
    end
  end
end
