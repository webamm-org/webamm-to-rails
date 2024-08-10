require 'spec_helper'

RSpec.describe WamlToRails::Sources::Migrations::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      table_definition = WamlToRails::Definition::Database::Schema.new(table: 'users', indices: [], columns: [])

      expected_definition = <<~RUBY
        class CreateUsers < ActiveRecord::Migration[7.1]
        end
      RUBY

      expect(
        described_class.new(table_definition: table_definition).render
      ).to eq(expected_definition)
    end
  end
end
