require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::AssociationDefinition::Presenter do
  describe '#render' do
    context 'when association is belongs_to' do
      it 'returns the association definition when association is optional' do
        expect(
          described_class.new(association: { 'type' => 'belongs_to', 'required' => false, 'destination' => 'companies' }).render
        ).to eq('belongs_to :company, optional: true')
      end

      it 'returns the association definition when association is required' do
        expect(
          described_class.new(association: { 'type' => 'belongs_to', 'required' => true, 'destination' => 'companies' }).render
        ).to eq('belongs_to :company')
      end
    end

    it 'raises error when association type is unknown' do
      expect {
        described_class.new(association: { type: 'unknown' }).render
      }.to raise_error(WamlToRails::Sources::Models::AssociationDefinition::Presenter::UnknownAssociationType)
    end
  end
end
