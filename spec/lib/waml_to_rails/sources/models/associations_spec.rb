require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Associations do
  describe '#collection' do
    context 'when processing table that is part of habtm' do
      it 'returns standard collection' do
        table_definition = {
          'table' => 'companies',
          'columns' => [],
          'options' => {}
        }

        waml_definition = {
          'schema' => [
            {
              'table' => 'companies_tags',
              'columns' => []
            }
          ],
          'associations' => [
            {
              'type' => 'has_many_and_belongs_to_many',
              'source' => 'companies',
              'destination' => 'tags',
              'required' => false,
              'options' => {
                'habtm_table' => 'companies_tags'
              }
            }
          ]
        }

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
        table_definition = {
          'table' => 'companies',
          'columns' => [],
          'options' => {}
        }

        waml_definition = {
          'schema' => [
            {
              'table' => 'companies_tags',
              'columns' => [
                {
                  'name' => 'verified',
                  'type' => 'boolean'
                }
              ]
            }
          ],
          'associations' => [
            {
              'type' => 'has_many_and_belongs_to_many',
              'source' => 'companies',
              'destination' => 'tags',
              'required' => false,
              'options' => {
                'habtm_table' => 'companies_tags'
              }
            }
          ]
        }

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
        table_definition = {
          'table' => 'users',
          'columns' => [],
          'options' => {}
        }

        waml_definition = {
          'associations' => [
            {
              'type' => 'belongs_to',
              'source' => 'users',
              'destination' => 'companies',
              'required' => true
            },
            {
              'type' => 'has_many',
              'source' => 'users',
              'destination' => 'posts',
              'required' => false
            }
          ]
        }

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
        table_definition = {
          'table' => 'companies_tags',
          'columns' => [],
          'options' => {
            'habtm' => true,
            'habtm_tables' => ['tags', 'companies']
          }
        }

        waml_definition = {
          'associations' => []
        }

        expect(
          described_class.new(
            waml_definition: waml_definition,
            table_definition: table_definition
          ).collection
        ).to eq([])
      end

      it 'returns habtm with columns collection' do
        table_definition = {
          'table' => 'companies_tags',
          'columns' => [
            {
              'name' => 'verified',
              'type' => 'boolean'
            }
          ],
          'options' => {
            'habtm' => true,
            'habtm_tables' => ['tags', 'companies']
          }
        }

        waml_definition = {
          'associations' => []
        }

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
