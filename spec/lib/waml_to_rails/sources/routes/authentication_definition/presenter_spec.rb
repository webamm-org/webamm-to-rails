require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Routes::AuthenticationDefinition::Presenter do
  describe '#render' do
    it 'returns nil if authentication is not present' do
      waml_definition = ::WamlToRails::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(nil)
    end

    it 'returns the authentication definition' do
      waml_definition = ::WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          },
          {
            table: 'admins',
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
        described_class.new(waml_definition: waml_definition).render
      ).to eq("devise_for :users\ndevise_for :admins")
    end
  end
end
