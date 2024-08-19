require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Views::Resource::NewDefinition::Presenter do
  describe '#render?' do
    it 'returns false if resource does not include create action' do
      crud_definition = Webamm::Database::Crud.new(
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

    it 'returns true if resource includes create action' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'create',
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
      crud_definition = Webamm::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'index',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'create',
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
