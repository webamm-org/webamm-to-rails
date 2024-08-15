require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::AttachmentDefinition::Presenter do
  describe '#render' do
    it 'returns attachment definition for single file' do
      column = Waml::Definition::Database::Schema::Column.new(
        name: 'avatar', type: 'file', default: nil, null: false
      )

      expect(
        described_class.new(column: column).render
      ).to eq('has_one_attached :avatar')
    end

    it 'returns attachment definition for multiple files' do
      column = Waml::Definition::Database::Schema::Column.new(
        name: 'photos', type: 'file', default: nil, null: false
      )

      expect(
        described_class.new(column: column).render
      ).to eq('has_many_attached :photos')
    end
  end
end
