require 'spec_helper'

RSpec.describe WebammToRails::Sources::Controllers::ApplicationController::Definition do
  describe '#render' do
    it 'renders empty class' do
      waml_definition = Webamm::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          crud: [],
          schema: []
        }
      )

      expected_definition = <<~RUBY
        class ApplicationController < ActionController::Base
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'renders definition with devise groups' do
      waml_definition = Webamm::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          },
          {
            table: 'admins',
            features: []
          },
          {
            table: 'redactors',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [],
          crud: [
            {
              table: 'articles',
              actions: [
                {
                  name: 'index',
                  options: {
                    authentication: ['users', 'admins', 'redactors']
                  }
                },
                {
                  name: 'show',
                  options: {
                    authentication: ['users', 'redactors']
                  }
                },
                {
                  name: 'create',
                  options: {
                    authentication: ['admins', 'redactors']
                  }
                },
                {
                  name: 'update',
                  options: {
                    authentication: ['users']
                  }
                },
                {
                  name: 'destroy',
                  options: {}
                }
              ]
            }
          ]
        }
      )

      expected_definition = <<~RUBY
        class ApplicationController < ActionController::Base
          devise_group :group1, contains: [:user, :admin, :redactor]
          devise_group :group2, contains: [:user, :redactor]
          devise_group :group3, contains: [:admin, :redactor]
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
