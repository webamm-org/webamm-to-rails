require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Routes::Definition do
  describe '#render' do
    it 'returns the routes definition' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: [],
          crud: [
            {
              table: 'users',
              actions: [
                {
                  name: 'index',
                  options: {}
                },
                {
                  name: 'show',
                  options: {}
                }
              ]
            }
          ]
        }
      )

      expected_definition = <<~RUBY
        Rails.application.routes.draw do
          mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

          get "up" => "rails/health#show", as: :rails_health_check

          # Render dynamic PWA files from app/views/pwa/*
          get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
          get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

          devise_for :users

          resources :users, only: %i[index show]
        end
      RUBY

      expect(
        described_class.new(waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
