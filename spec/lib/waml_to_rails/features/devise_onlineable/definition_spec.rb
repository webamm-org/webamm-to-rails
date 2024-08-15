require 'spec_helper'

RSpec.describe ::WamlToRails::Features::DeviseOnlineable::Definition do
  describe '#collection' do
    it 'returns empty collection if online_indication is not present' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
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

      expect(
        described_class.new(waml_definition: waml_definition).collection
      ).to eq([])
    end

    it 'returns collection with online_indication if present' do
      waml_definition = ::Waml::Definition.new(
        authentication: [
          {
            table: 'moderators',
            features: ['online_indication']
          }
        ],
        database: {
          engine: 'postgresql',
          schema: [],
          relationships: []
        }
      )

      files = described_class.new(waml_definition: waml_definition).collection
      paths = [
        'app/channels/application_cable/connection.rb',
        'app/channels/online_channel.rb',
        'app/models/concerns/devise_onlineable.rb',
        'app/javascript/channels/consumer.js',
        'app/javascript/channels/index.js',
        'app/javascript/channels/online_channel.js'
      ]

      paths.each do |path|
        expect(files.map { |file| file[:path] }).to include(path)
      end
    end
  end
end
