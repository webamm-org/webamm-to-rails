require 'spec_helper'

RSpec.describe WebammToRails::Sources::Migrations::ColumnDefinition::Presenter do
  describe '#render' do
    context 'when rendering enum column' do
      it 'returns nil when column type is file' do
        column = Webamm::Database::Schema::Column.new(
          name: 'avatar',
          type: 'file',
          null: false,
          default: nil
        )

        expect(described_class.new(column: column).render).to eq(nil)
      end

      it 'returns standard enum column definition' do
        column = Webamm::Database::Schema::Column.new(
          name: 'status',
          type: 'enum_column',
          values: ['active', 'inactive'],
          null: false,
          default: nil
        )

        expect(
          described_class.new(column: column).render
        ).to eq(
          't.integer :status, null: false'
        )
      end

      it 'returns enum column with default option' do
        column = Webamm::Database::Schema::Column.new(
          name: 'status',
          type: 'enum_column',
          values: ['active', 'inactive'],
          default: 'active',
          null: false
        )

        expect(
          described_class.new(column: column).render
        ).to eq(
          't.integer :status, null: false, default: 0'
        )
      end
    end

    context 'when rendering non enum column' do
      it 'returns standard column definition' do
        column = Webamm::Database::Schema::Column.new(
          name: 'first_name',
          type: 'string',
          default: nil,
          null: true
        )

        expect(
          described_class.new(column: column).render
        ).to eq(
          't.string :first_name, null: true'
        )
      end

      it 'returns column definition with default option for string' do
        column = Webamm::Database::Schema::Column.new(
          name: 'first_name',
          type: 'string',
          default: 'test',
          null: true
        )

        expect(
          described_class.new(column: column).render
        ).to eq(
          "t.string :first_name, null: true, default: 'test'"
        )
      end

      it 'returns column definition with default option for integer' do
        column = Webamm::Database::Schema::Column.new(
          name: 'age',
          type: 'integer',
          default: '18',
          null: false
        )

        expect(
          described_class.new(column: column).render
        ).to eq(
          "t.integer :age, null: false, default: 18"
        )
      end
    end
  end
end
