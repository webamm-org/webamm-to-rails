require 'spec_helper'

RSpec.describe WebammToRails::Sources::Migrations::ClassDefinition::Presenter do
  describe '#render' do
    it 'returns migration class definition' do
      expect(
        described_class.new(table_name: 'users').render
      ).to eq(
        "class CreateUsers < ActiveRecord::Migration[7.1]"
      )
    end

    it 'returns migration class with different rails version' do
      expect(
        described_class.new(table_name: 'users').render(rails_version: '7.0')
      ).to eq(
        "class CreateUsers < ActiveRecord::Migration[7.0]"
      )
    end
  end
end
