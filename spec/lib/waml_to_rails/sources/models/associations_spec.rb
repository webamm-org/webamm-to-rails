require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Associations do
  describe '#collection' do
    it 'returns collection for parent child association' do
      table_definition = Waml::Definition::Database::Schema.new(
        table: 'categories',
        columns: [],
        options: {},
        indices: []
      )

      waml_definition = Waml::Definition.new(
        database: {
          engine: 'postgresql',
          schema: [
            {
              table: 'categories',
              columns: [],
              indices: []
            }
          ],
          relationships: [
            {
              type: 'parent_children',
              source: 'categories',
              required: true
            }
          ]
        }
      )

      expect(
        described_class.new(
          waml_definition: waml_definition,
          table_definition: table_definition
        ).collection
      ).to eq([
        "belongs_to :parent, optional: true, class_name: 'Category'",
        "has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy"
      ])
    end

    context 'when processing table that is part of habtm' do
      it 'returns standard collection' do
        table_definition = Waml::Definition::Database::Schema.new(
          table: 'companies',
          columns: [],
          options: {},
          indices: []
        )

        waml_definition = Waml::Definition.new(
          database: {
            engine: 'postgresql',
            schema: [
              {
                table: 'companies_tags',
                columns: [],
                indices: []
              }
            ],
            relationships: [
              {
                type: 'has_many_and_belongs_to_many',
                source: 'companies',
                destination: 'tags',
                required: false,
                options: {
                  habtm_table: 'companies_tags'
                }
              }
            ]
          }
        )

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([
          'has_and_belongs_to_many :tags'
        ])
      end

      it 'returns collection with association to habtm table with columns' do
        table_definition = Waml::Definition::Database::Schema.new(
          table: 'companies',
          columns: [],
          options: {},
          indices: []
        )

        waml_definition = Waml::Definition.new(
          database: {
            engine: 'postgresql',
            schema: [
              {
                table: 'companies_tags',
                columns: [
                  {
                    name: 'verified',
                    type: 'boolean',
                    null: false,
                    default: nil
                  }
                ],
                indices: []
              }
            ],
            relationships: [
              {
                type: 'has_many_and_belongs_to_many',
                source: 'companies',
                destination: 'tags',
                required: false,
                options: {
                  habtm_table: 'companies_tags'
                }
              }
            ]
          }
        )

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([
          'has_many :companies_tags',
          'has_many :tags, through: :companies_tags'
        ])
      end
    end

    context 'when processing habtm table associations' do
      it 'returns standard collection' do
        table_definition = Waml::Definition::Database::Schema.new(
          table: 'users',
          columns: [],
          options: {},
          indices: []
        )

        waml_definition = Waml::Definition.new(
          database: {
            engine: 'postgresql',
            schema: [],
            relationships: [
              {
                type: 'belongs_to',
                source: 'users',
                destination: 'companies',
                required: true
              },
              {
                type: 'has_many',
                source: 'users',
                destination: 'posts',
                required: false
              }
            ]
          }
        )

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([
          'belongs_to :company',
          'has_many :posts'
        ])
      end

      it 'returns habtm collection' do
        table_definition = Waml::Definition::Database::Schema.new(
          table: 'companies_tags',
          columns: [],
          options: {
            habtm: true,
            habtm_tables: ['tags', 'companies']
          },
          indices: []
        )

        waml_definition = Waml::Definition.new(
          database: {
            engine: 'postgresql',
            schema: [],
            relationships: []
          }
        )

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([])
      end

      it 'returns habtm with columns collection' do
        table_definition = Waml::Definition::Database::Schema.new(
          table: 'companies_tags',
          columns: [
            {
              name: 'verified',
              type: 'boolean',
              null: false,
              default: nil
            }
          ],
          options: {
            habtm: true,
            habtm_tables: ['tags', 'companies']
          },
          indices: []
        )

        waml_definition = Waml::Definition.new(
          database: {
            engine: 'postgresql',
            schema: [],
            relationships: []
          }
        )

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([
          'belongs_to :tag',
          'belongs_to :company'
        ])
      end
    end
  end
end
