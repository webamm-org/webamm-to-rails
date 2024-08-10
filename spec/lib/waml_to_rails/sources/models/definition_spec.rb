require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      table_definition = {
        'table' => 'users',
        'options' => {}
      }

      expected_definition = <<~RUBY
        class User < ApplicationRecord
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition, waml_definition: { 'associations' => [] }).render
      ).to eq(expected_definition)
    end

    it 'returns class definition with base associations' do
      table_definition = {
        'table' => 'users',
        'options' => {}
      }

      expected_definition = <<~RUBY
        class User < ApplicationRecord
          belongs_to :company
          has_many :tasks
          has_and_belongs_to_many :tags
        end
      RUBY

      waml_definition = {
        'associations' => [
          { 'source' => 'users', 'type' => 'belongs_to', 'destination' => 'companies', 'required' => true },
          { 'source' => 'companies', 'type' => 'has_many', 'destination' => 'users' },
          { 'source' => 'users', 'type' => 'has_many', 'destination' => 'tasks' },
          { 'source' => 'tasks', 'type' => 'belongs_to', 'destination' => 'users' },
          { 'source' => 'users', 'type' => 'has_many_and_belongs_to_many', 'destination' => 'tags' },
          { 'source' => 'tags', 'type' => 'has_many_and_belongs_to_many', 'destination' => 'users' }
        ]
      }

      expect(
        described_class.new(table_definition: table_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
