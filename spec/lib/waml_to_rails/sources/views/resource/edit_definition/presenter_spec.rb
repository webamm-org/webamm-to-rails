require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Views::Resource::EditDefinition::Presenter do
  describe '#render?' do
    it 'returns false if resource does not include update action' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render?
      ).to eq(false)
    end

    it 'returns true if resource includes update action' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'update',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render?
      ).to eq(true)
    end
  end

  describe '#render' do
    it 'renders full view' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'index',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'update',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        '<%= render "form", article: @article %>'
      )
    end
  end
end
