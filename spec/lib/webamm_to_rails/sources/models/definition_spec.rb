require 'spec_helper'

RSpec.describe WebammToRails::Sources::Models::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      table_definition = Webamm::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      waml_definition = Webamm::Definition.new(database: { relationships: [], schema: [], engine: 'postgresql' })

      expected_definition = <<~RUBY
        class User < ApplicationRecord
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with concerns' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: []
      )
      waml_definition = Webamm::Definition.new(
        database: { relationships: [], schema: [], engine: 'postgresql' },
        authentication: [
          {
            table: 'users',
            features: ['online_indication']
          }
        ]
      )

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          include DeviseOnlineable
          devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with attachments' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Webamm::Database::Schema::Column.new(name: 'avatar', type: 'file', default: nil, null: false),
          Webamm::Database::Schema::Column.new(name: 'photos', type: 'file', default: nil, null: false)
        ]
      )
      waml_definition = Webamm::Definition.new(database: { relationships: [], schema: [], engine: 'postgresql' })

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          has_one_attached :avatar
          has_many_attached :photos
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with enums' do
      table_definition = Webamm::Definition::Database::Schema.new(
        table: 'users',
        indices: [],
        columns: [
          Webamm::Database::Schema::Column.new(name: 'status', type: 'enum_column', values: ['accepted', 'rejected'], default: 'accepted', null: false)
        ]
      )
      waml_definition = Webamm::Definition.new(database: { relationships: [], schema: [], engine: 'postgresql' })

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          enum :status, { accepted: 0, rejected: 1 }, default: :accepted
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with devise' do
      table_definition = Webamm::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      waml_definition = Webamm::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          relationships: [],
          schema: [
            { table: 'users', columns: [], indices: [] }
          ],
          engine: 'postgresql'
        }
      )

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          devise :database_authenticatable, :validatable, :rememberable, :recoverable, :trackable
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with base associations' do
      table_definition = Webamm::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])
      waml_definition = Webamm::Definition.new(database: {
        relationships: [
          {
            source: 'users',
            type: 'belongs_to',
            destination: 'companies',
            required: true
          },
          {
            source: 'companies',
            type: 'has_many',
            destination: 'users',
            required: true
          },
          {
            source: 'users',
            type: 'has_many',
            destination: 'tasks',
            required: true
          },
          {
            source: 'tasks',
            type: 'belongs_to',
            destination: 'users',
            required: true
          },
          {
            source: 'users',
            type: 'has_many_and_belongs_to_many',
            destination: 'tags',
            options: { habtm_table: 'companies_tags' },
            required: true
          },
          {
            source: 'tags',
            type: 'has_many_and_belongs_to_many',
            destination: 'users',
            options: { habtm_table: 'companies_tags' },
            required: true
          }
        ],
        schema: [
          { table: 'companies_tags', columns: [], indices: [] }
        ],
        engine: 'postgresql'
      })

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          belongs_to :company
          has_many :tasks
          has_and_belongs_to_many :tags
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
