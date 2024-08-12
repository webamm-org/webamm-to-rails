require 'spec_helper'

RSpec.describe WamlToRails::Sources::Views::Definition do
  describe '#collection' do
    it 'returns collection of views with devise' do
      waml_definition = WamlToRails::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          },
          {
            table: 'admins',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      views = described_class.new(waml_definition: waml_definition).collection

      expected_views = [
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
        'app/views/users/shared/_links.html.erb',
        'app/views/admins/confirmations/new.html.erb',
        'app/views/admins/mailer/confirmation_instructions.html.erb',
        'app/views/admins/mailer/reset_password_instructions.html.erb',
        'app/views/admins/mailer/email_changed.html.erb',
        'app/views/admins/mailer/password_change.html.erb',
        'app/views/admins/passwords/edit.html.erb',
        'app/views/admins/passwords/new.html.erb',
        'app/views/admins/registrations/edit.html.erb',
        'app/views/admins/registrations/new.html.erb',
        'app/views/admins/sessions/new.html.erb',
        'app/views/admins/shared/_links.html.erb'
      ]

      expect(views.size).to eq(expected_views.size)

      expected_views.each do |path|
        expect(views.map { |v| v[:path] }).to include(path)
      end
    end
  end
end
