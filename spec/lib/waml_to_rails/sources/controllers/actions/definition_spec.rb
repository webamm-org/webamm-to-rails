require 'spec_helper'

RSpec.describe WamlToRails::Sources::Controllers::Actions::Definition do
  describe '#collection' do
    it 'returns grouped collection that should be rendered' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {}
          },
          {
            name: 'show',
            options: {}
          },
          {
            name: 'create',
            options: {}
          },
          {
            name: 'update',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          },
          {
            name: 'new',
            options: {}
          },
          {
            name: 'edit',
            options: {}
          }
        ]
      )

      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
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
          ],
          crud: [crud_definition]
        }
      )

      collection = described_class.new(
        crud_definition: crud_definition,
        waml_definition: waml_definition
      ).collection

      expect(collection[:private].size).to eq(1)
      expect(collection[:public].size).to eq(7)
    end
  end
end
