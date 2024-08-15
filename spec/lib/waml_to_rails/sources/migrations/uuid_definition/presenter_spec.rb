require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Migrations::UuidDefinition::Presenter do
  describe '#render' do
    it 'returns the rendered content' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: [],
              options: {}
            }
          ]
        }
      )

      expected_definition = <<~RUBY
        class EnableUuid < ActiveRecord::Migration[7.1]
          def change
            enable_extension "pgcrypto"
          end
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end

  describe '#file_name' do
    it 'returns the file name' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: [],
              options: {}
            }
          ]
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).file_name('0001')
      ).to eq('db/migrate/0001_enable_uuid.rb')
    end
  end

  describe '#render?' do
    it 'returns false if none of tables has UUID' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: [],
              options: {}
            }
          ]
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).render?
      ).to eq(false)
    end

    it 'returns true if at least one table has UUID' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [],
              indices: [],
              options: {
                use_uuid: true
              }
            }
          ]
        }
      )

      expect(
        described_class.new(waml_definition: waml_definition).render?
      ).to eq(true)
    end
  end
end
