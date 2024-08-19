require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Views::Devise::Invitable::Presenter do
  describe '#collection' do
    it 'returns a collection of views' do
      views = described_class.new(table_name: 'users').collection

      expect(views.map { |v| v[:path] }).to eq([
        'app/views/users/mailer/invitation_instructions.html.erb',
        'app/views/users/invitations/edit.html.erb',
        'app/views/users/invitations/new.html.erb'
      ])
    end
  end
end
