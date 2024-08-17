require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Views::Resource::FormDefinition::Presenter do
  describe '#render?' do
    it 'returns false if resource does not include create or update action' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(false)
    end

    it 'returns true if resource includes create action' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'create',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(true)
    end

    it 'returns true if resource includes update action' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render?
      ).to eq(true)
    end
  end

  describe '#render' do
    it 'renders view with string field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
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
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/string_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with integer field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'age',
                  type: 'integer',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/number_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with boolean field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'enabled',
                  type: 'boolean',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/boolean_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with text field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'bio',
                  type: 'text',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/text_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with float field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'age',
                  type: 'float',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/number_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with datetime field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'published_at',
                  type: 'datetime',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/datetime_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with time field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'published_at',
                  type: 'time',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/time_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with date field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'published_at',
                  type: 'date',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/date_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with enum field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'status',
                  type: 'enum_column',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/enum_field.html.erb', __dir__)).strip
      )
    end

    it 'renders view with file field' do
      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'photo',
                  type: 'file',
                  null: false,
                  default: nil
                }
              ]
            }
          ],
          relationships: []
        }
      )

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
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(
        File.read(File.expand_path('variants/file_field.html.erb', __dir__)).strip
      )
    end
  end
end
