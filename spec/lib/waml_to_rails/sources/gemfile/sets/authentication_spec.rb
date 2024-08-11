require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Gemfile::Sets::Authentication do
  describe '#collection' do
    it 'returns empty collection if waml has no authentication' do
      waml = ::WamlToRails::Definition.new(
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml).collection
      ).to eq([])
    end

    it 'returns base collection if waml has authentication' do
      waml = ::WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users'
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml).collection
      ).to eq([
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise',
          version: '4.9.4',
          required: true,
          group: :default,
          platforms: []
        )
      ])
    end

    it 'returns base collection invitable lib if invitations are enabled' do
      waml = ::WamlToRails::Definition.new(
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

      expect(
        described_class.new(waml_definition: waml).collection
      ).to eq([
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise',
          version: '4.9.4',
          required: true,
          group: :default,
          platforms: []
        ),
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise_invitable',
          version: '2.0.9',
          required: true,
          group: :default,
          platforms: []
        )
      ])
    end

    it 'returns base collection otp lib if otp is enabled' do
      waml = ::WamlToRails::Definition.new(
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

      expect(
        described_class.new(waml_definition: waml).collection
      ).to eq([
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise',
          version: '4.9.4',
          required: true,
          group: :default,
          platforms: []
        ),
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise-otp',
          version: '0.7.1',
          required: true,
          group: :default,
          platforms: []
        )
      ])
    end

    it 'returns base collection with multiple libs' do
      waml = ::WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations', 'two_factor_authentication']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expect(
        described_class.new(waml_definition: waml).collection
      ).to eq([
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise',
          version: '4.9.4',
          required: true,
          group: :default,
          platforms: []
        ),
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise_invitable',
          version: '2.0.9',
          required: true,
          group: :default,
          platforms: []
        ),
        ::WamlToRails::Sources::Gemfile::Gem.new(
          name: 'devise-otp',
          version: '0.7.1',
          required: true,
          group: :default,
          platforms: []
        )
      ])
    end
  end
end
