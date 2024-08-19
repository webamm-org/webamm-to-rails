require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Views::Devise::Presenter do
  describe '#collection' do
    it 'returns an empty collection when authentication is not enabled' do
      waml_definition = Webamm::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )
      
      expect(
        described_class.new(waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns collection of standard devise views' do
      waml_definition = Webamm::Definition.new(
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

    it 'returns collection of standard devise views and invitable' do
      waml_definition = Webamm::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['invitations']
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
        'app/views/users/mailer/invitation_instructions.html.erb',
        'app/views/users/invitations/edit.html.erb',
        'app/views/users/invitations/new.html.erb',
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

    it 'returns collection of standard devise views and otp' do
      waml_definition = Webamm::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['two_factor_authentication']
          },
          {
            table: 'admins',
            features: ['two_factor_authentication']
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
        'app/views/admins/shared/_links.html.erb',
        'app/views/devise/otp_credentials/show.html.erb',
        'app/views/devise/otp_credentials/refresh.html.erb',
        'app/views/devise/otp_tokens/_token_secret.html.erb',
        'app/views/devise/otp_tokens/_trusted_devices.html.erb',
        'app/views/devise/otp_tokens/edit.html.erb',
        'app/views/devise/otp_tokens/recovery_codes.html.erb',
        'app/views/devise/otp_tokens/recovery.html.erb',
        'app/views/devise/otp_tokens/show.html.erb'
      ]

      expect(views.size).to eq(expected_views.size)

      expected_views.each do |path|
        expect(views.map { |v| v[:path] }).to include(path)
      end
    end
  end
end
