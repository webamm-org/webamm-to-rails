require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Views::Devise::Standard::Presenter do
  describe '#collection' do
    it 'returns a collection of views' do
      views = described_class.new(table_name: 'users').collection

      expect(views.map { |v| v[:path] }).to eq([
        'app/views/users/confirmations/new.html.erb',
        'app/views/users/mailer/confirmation_instructions.html.erb',
        'app/views/users/mailer/reset_password_instructions.html.erb',
        'app/views/users/mailer/email_changed.html.erb',
        'app/views/users/mailer/password_change.html.erb',
        'app/views/users/passwords/edit.html.erb',
        'app/views/users/passwords/new.html.erb',
        'app/views/users/registrations/edit.html.erb',
        'app/views/users/registrations/new.html.erb',
        'app/views/users/sessions/new.html.erb',
        'app/views/users/shared/_links.html.erb'
      ])
    end
  end
end
