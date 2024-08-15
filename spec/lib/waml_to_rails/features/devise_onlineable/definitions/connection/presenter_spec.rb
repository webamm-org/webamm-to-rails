require 'spec_helper'

RSpec.describe ::WamlToRails::Features::DeviseOnlineable::Definitions::Connection::Presenter do
  describe '#render' do
    it 'renders connection file content' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: ['online_indication']
          },
          {
            table: 'admins',
            features: ['online_indication']
          },
          {
            table: 'moderators',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      expected_definition = <<~RUBY
        # frozen_string_literal: true

        module ApplicationCable
          class Connection < ActionCable::Connection::Base
            identified_by :current_user

            def connect
              self.current_user = find_verified_user
            end

            private

            def find_verified_user
              env["warden"].user(:user) || env["warden"].user(:admin) || reject_unauthorized_connection
            end
          end
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
