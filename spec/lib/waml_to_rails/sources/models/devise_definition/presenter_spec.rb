require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::DeviseDefinition::Presenter do
  describe '#render' do
    it 'renders nothing if model is not authenticated' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: []
            }
          ]
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).render
      ).to eq(nil)
    end

    it 'returns base devise definition' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: []
            }
          ]
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).render
      ).to eq('devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable')
    end

    it 'returns base devise definition with allow_sign_up feature' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['allow_sign_up']
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: []
            }
          ]
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).render
      ).to eq('devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable, :registerable, :confirmable')
    end

    it 'returns base devise definition with invitations feature' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations']
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: []
            }
          ]
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).render
      ).to eq('devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable, :invitable')
    end

    it 'returns base devise definition with two_factor_authentication feature' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['two_factor_authentication']
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: []
            }
          ]
        }
      )

      expect(
        described_class.new(table_name: 'users', waml_definition: waml_definition).render
      ).to eq('devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable, :otp_authenticatable')
    end
  end
end
