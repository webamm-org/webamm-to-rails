require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::EnumDefinition::Presenter do
  describe '#render' do
    it 'returns definition of enum' do
      column = Waml::Definition::Database::Schema::Column.new(
        name: 'status',
        type: 'enum_column',
        values: ['accepted', 'rejected'],
        default: nil,
        null: false
      )

      presenter = described_class.new(column: column)

      expect(presenter.render).to eq('enum :status, { accepted: 0, rejected: 1 }')
    end

    it 'returns definition of enum with default value' do
      column = Waml::Definition::Database::Schema::Column.new(
        name: 'status',
        type: 'enum_column',
        values: ['accepted', 'rejected'],
        default: 'accepted',
        null: false
      )

      presenter = described_class.new(column: column)

      expect(presenter.render).to eq('enum :status, { accepted: 0, rejected: 1 }, default: :accepted')
    end
  end
end
