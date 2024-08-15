require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Initializers::DeviseDefinition::Presenter do
  describe '#render' do
    it 'returns base devise initializer' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      result = described_class.new(waml_definition: waml_definition).render

      expect(result).to include('Devise.setup do |config|')
      expect(result).not_to include('Devise OTP Extension')
      expect(result).not_to include('Configuration for :invitable')
    end

    it 'renders devise initializer with two factor authentication' do
      waml_definition = Waml::Definition.new(
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

      result = described_class.new(waml_definition: waml_definition).render

      expect(result).to include('Devise.setup do |config|')
      expect(result).to include('Devise OTP Extension')
      expect(result).not_to include('Configuration for :invitable')
    end

    it 'renders devise initializer with invitable' do
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

      result = described_class.new(waml_definition: waml_definition).render

      expect(result).to include('Devise.setup do |config|')
      expect(result).not_to include('Devise OTP Extension')
      expect(result).to include('Configuration for :invitable')
    end
  end
end
