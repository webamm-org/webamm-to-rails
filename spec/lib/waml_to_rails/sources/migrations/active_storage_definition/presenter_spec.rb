require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Migrations::ActiveStorageDefinition::Presenter do
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
        # This migration comes from active_storage (originally 20170806125915)
        class CreateActiveStorageTables < ActiveRecord::Migration[7.1]
          def change
            # Use Active Record's configured type for primary and foreign keys
            primary_key_type, foreign_key_type = primary_and_foreign_key_types

            create_table :active_storage_blobs, id: primary_key_type do |t|
              t.string :key, null: false
              t.string :filename, null: false
              t.string :content_type
              t.text :metadata
              t.string :service_name, null: false
              t.bigint :byte_size, null: false
              t.string :checksum

              if connection.supports_datetime_with_precision?
                t.datetime :created_at, precision: 6, null: false
              else
                t.datetime :created_at, null: false
              end

              t.index [:key], unique: true
            end

            create_table :active_storage_attachments, id: primary_key_type do |t|
              t.string :name, null: false
              t.references :record, null: false, polymorphic: true, index: false, type: foreign_key_type
              t.references :blob, null: false, type: foreign_key_type

              if connection.supports_datetime_with_precision?
                t.datetime :created_at, precision: 6, null: false
              else
                t.datetime :created_at, null: false
              end

              t.index [:record_type, :record_id, :name, :blob_id], name: :index_active_storage_attachments_uniqueness, unique: true
              t.foreign_key :active_storage_blobs, column: :blob_id
            end

            create_table :active_storage_variant_records, id: primary_key_type do |t|
              t.belongs_to :blob, null: false, index: false, type: foreign_key_type
              t.string :variation_digest, null: false

              t.index [:blob_id, :variation_digest], name: :index_active_storage_variant_records_uniqueness, unique: true
              t.foreign_key :active_storage_blobs, column: :blob_id
            end
          end

          private

          def primary_and_foreign_key_types
            config = Rails.configuration.generators
            setting = config.options[config.orm][:primary_key_type]
            primary_key_type = setting || :primary_key
            foreign_key_type = setting || :bigint
            [primary_key_type, foreign_key_type]
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
      ).to eq('db/migrate/0001_create_active_storage_tables.rb')
    end
  end

  describe '#render?' do
    it 'returns false if none of tables has file column' do
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

    it 'returns true if at least one table has file column' do
      waml_definition = ::Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              columns: [
                {
                  name: 'avatar',
                  type: 'file',
                  default: nil,
                  null: true
                }
              ],
              indices: [],
              options: {}
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
