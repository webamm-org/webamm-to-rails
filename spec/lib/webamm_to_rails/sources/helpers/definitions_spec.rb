require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Helpers::Definitions do
  describe '#collection' do
    it 'returns collection with devise' do
      waml_definition = ::Webamm::Definition.new(
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
