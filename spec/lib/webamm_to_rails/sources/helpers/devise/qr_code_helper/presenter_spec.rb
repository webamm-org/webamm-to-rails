require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Helpers::Devise::QrCodeHelper::Presenter do
  describe '#render' do
    it 'renders helper code' do
      expect(
        described_class.new.render
      ).to include('DeviseQrCodeHelper')
    end
  end
end
