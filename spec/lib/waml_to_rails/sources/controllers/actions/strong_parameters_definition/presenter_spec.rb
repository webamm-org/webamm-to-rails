require 'spec_helper'

RSpec.describe WamlToRails::Sources::Controllers::Actions::StrongParametersDefinition::Presenter do
  describe '#render?' do
    it 'returns false if create or update action is not present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {}
          }
        ]
      )

      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          crud: [crud_definition],
          relationships: [],
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'first_name',
                  type: 'string',
                  default: nil,
                  null: true
                },
                {
                  name: 'last_name',
                  type: 'string',
                  default: nil,
                  null: true
                }
              ]
            }
          ]
        }
      )

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(false)
    end

    it 'returns true if create action is present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'create',
            options: {}
          }
        ]
      )

      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          crud: [crud_definition],
          relationships: [],
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'first_name',
                  type: 'string',
                  default: nil,
                  null: true
                },
                {
                  name: 'last_name',
                  type: 'string',
                  default: nil,
                  null: true
                }
              ]
            }
          ]
        }
      )

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(true)
    end

    it 'returns true if update action is present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'update',
            options: {}
          }
        ]
      )

      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          crud: [crud_definition],
          relationships: [],
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'first_name',
                  type: 'string',
                  default: nil,
                  null: true
                },
                {
                  name: 'last_name',
                  type: 'string',
                  default: nil,
                  null: true
                }
              ]
            }
          ]
        }
      )

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(true)
    end
  end
end
