require 'spec_helper'

RSpec.describe WebammToRails::Sources::Routes::ResourceDefinition::Presenter do
  describe '#render' do
    it 'renders resource with all actions' do
      crud_definition = ::Webamm::Database::Crud.new(
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
      crud_definition = ::Webamm::Database::Crud.new(
        table: 'users',
        actions: [
          { name: 'index', options: {} },
          { name: 'show', options: {} },
          { name: 'create', options: {} },
          { name: 'update', options: {} }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        'resources :users, only: %i[index show create update edit new]'
      )
    end
  end
end
