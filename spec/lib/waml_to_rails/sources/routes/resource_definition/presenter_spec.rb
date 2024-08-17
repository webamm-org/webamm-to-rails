require 'spec_helper'

RSpec.describe WamlToRails::Sources::Routes::ResourceDefinition::Presenter do
  describe '#render' do
    it 'renders resource with all actions' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          { name: 'index', options: {} },
          { name: 'show', options: {} },
          { name: 'new', options: {} },
          { name: 'create', options: {} },
          { name: 'edit', options: {} },
          { name: 'update', options: {} },
          { name: 'destroy', options: {} }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        'resources :users'
      )
    end

    it 'renders resource without some actions' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          { name: 'index', options: {} },
          { name: 'show', options: {} },
          { name: 'new', options: {} },
          { name: 'create', options: {} },
          { name: 'edit', options: {} }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        'resources :users, only: %i[index show new create edit]'
      )
    end
  end
end
