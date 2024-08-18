require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Filters::DeviseDefinition::Presenter do
  describe '#collection' do
    it 'returns a collection of devise filters' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'index',
            options: {
              authentication: ['users', 'admins', 'redactors']
            }
          },
          {
            name: 'show',
            options: {
              authentication: ['users', 'redactors']
            }
          },
          {
            name: 'create',
            options: {
              authentication: ['admins', 'redactors']
            }
          },
          {
            name: 'update',
            options: {
              authentication: ['users']
            }
          },
          {
            name: 'destroy',
            options: {
              authentication: ['users']
            }
          }
        ]
      )

      waml_definition = Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          },
          {
            table: 'admins',
            features: []
          },
          {
            table: 'redactors',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [],
          crud: [crud_definition]
        }
      )

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).collection
      ).to eq([
        'before_action :authenticate_group1!, only: [:index]',
        'before_action :authenticate_group2!, only: [:show]',
        'before_action :authenticate_group3!, only: [:create]',
        'before_action :authenticate_user!, only: [:update, :destroy]'
      ])
    end
  end
end
