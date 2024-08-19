require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Views::Resource::ShowDefinition::Presenter do
  describe '#render?' do
    it 'returns false if resource does not include show action' do
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
      ).to eq(false)
    end

    it 'returns true if resource includes show action' do
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
      ).to eq(true)
    end
  end

  describe '#render' do
    it 'renders full view' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'show',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'index',
            options: {}
          },
          {
            name: 'update',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        File.read(File.expand_path('variants/full.html.erb', __dir__)).strip
      )
    end

    it 'renders view without index action' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'show',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'update',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        File.read(File.expand_path('variants/without_index.html.erb', __dir__)).strip
      )
    end

    it 'renders view without destroy action' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'show',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'update',
            options: {}
          },
          {
            name: 'index',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        File.read(File.expand_path('variants/without_destroy.html.erb', __dir__)).strip
      )
    end

    it 'renders view without edit action' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'articles',
        actions: [
          {
            name: 'show',
            options: {
              model_attributes: ['title', 'content']
            }
          },
          {
            name: 'index',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        File.read(File.expand_path('variants/without_edit.html.erb', __dir__)).strip
      )
    end
  end
end
