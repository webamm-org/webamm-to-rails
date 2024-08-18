require 'spec_helper'

RSpec.describe WamlToRails::Sources::Controllers::Authentication::DeviseGroups::Presenter do
  describe '#mappings' do
    it 'returns devise mappings' do
      waml_definition = Waml::Definition.new(
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

      expect(
        described_class.new(waml_definition: waml_definition).mappings
      ).to eq({
        ["users", "admins", "redactors"] => "group1",
        ["users", "redactors"] => "group2",
        ["admins", "redactors"] => "group3",
        ["users"] => "users"
      })
    end
  end
end
