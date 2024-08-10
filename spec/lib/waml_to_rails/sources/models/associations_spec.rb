require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Associations do
  describe '#collection' do
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
