require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Views::Devise::Otp::Presenter do
  describe '#collection' do
    it 'returns a collection of views' do
      views = described_class.new.collection

      expect(views.map { |v| v[:path] }).to eq([
        'app/views/devise/otp_credentials/show.html.erb',
        'app/views/devise/otp_credentials/refresh.html.erb',
        'app/views/devise/otp_tokens/_token_secret.html.erb',
        'app/views/devise/otp_tokens/_trusted_devices.html.erb',
        'app/views/devise/otp_tokens/edit.html.erb',
        'app/views/devise/otp_tokens/recovery_codes.html.erb',
        'app/views/devise/otp_tokens/recovery.html.erb',
        'app/views/devise/otp_tokens/show.html.erb'
      ])
    end
  end
end
