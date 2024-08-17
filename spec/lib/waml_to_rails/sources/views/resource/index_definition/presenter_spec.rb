require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Views::Resource::IndexDefinition::Presenter do
  describe '#render?' do
    it 'returns false if resource does not include index action' do
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

    it 'returns true if resource includes index action' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
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
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(
        File.read(File.expand_path('variants/full.html.erb', __dir__)).strip
      )
    end

    it 'renders view without destroy action' do
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
            name: 'show',
            options: {}
          },
          {
            name: 'create',
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

    it 'renders view without show action' do
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
            name: 'destroy',
            options: {}
          },
          {
            name: 'create',
            options: {}
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
        File.read(File.expand_path('variants/without_show.html.erb', __dir__)).strip
      )
    end

    it 'renders view without create action' do
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
            name: 'destroy',
            options: {}
          },
          {
            name: 'show',
            options: {}
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
        File.read(File.expand_path('variants/without_create.html.erb', __dir__)).strip
      )
    end
  end
end
