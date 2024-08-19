require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Views::Resource::Presenter do
  describe '#collection' do
    it 'returns collection of views for resource' do
      crud_definition = ::Webamm::Database::Crud.new(
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
          }
        ]
      )

      waml_definition = ::Webamm::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          crud: [crud_definition],
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'first_name',
                  type: 'string',
                  null: false,
                  default: nil
                }
              ]
            }
          ]
        }
      )

      views = described_class.new(
        crud_definition: crud_definition,
        waml_definition: waml_definition
      ).collection

      expect(views.count).to eq(4)

      expect(views.map { |view| view[:path] }).to eq([
        'app/views/users/index.html.erb',
        'app/views/users/new.html.erb',
        'app/views/users/show.html.erb',
        'app/views/users/_form.html.erb'
      ])
    end
  end
end
