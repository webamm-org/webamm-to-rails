require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Gemfile::GemDefinition::Presenter do
  describe '#render' do
    it 'returns the base gem definition' do
      gem = ::WamlToRails::Sources::Gemfile::Gem.new(
        name: 'rails', required: true, group: :default, platforms: [], version: nil
      )
      
      expect(
        described_class.new(gem: gem).render
      ).to eq(
        [:default, "gem 'rails'"]
      )
    end

    it 'returns the gem definition with version' do
      gem = ::WamlToRails::Sources::Gemfile::Gem.new(
        name: 'rails', required: true, group: :default, platforms: [], version: '7.2.0'
      )

      expect(
        described_class.new(gem: gem).render
      ).to eq(
        [:default, "gem 'rails', '7.2.0'"]
      )
    end

    it 'returns the gem definition with platforms' do
      gem = ::WamlToRails::Sources::Gemfile::Gem.new(
        name: 'rails', required: true, group: :default, platforms: [:ruby, :jruby], version: nil
      )

      expect(
        described_class.new(gem: gem).render
      ).to eq(
        [:default, "gem 'rails', platforms: %i[ruby jruby]"]
      )
    end

    it 'returns the gem definition with required flag' do
      gem = ::WamlToRails::Sources::Gemfile::Gem.new(
        name: 'rails', required: false, group: :default, platforms: [], version: nil
      )

      expect(
        described_class.new(gem: gem).render
      ).to eq(
        [:default, "gem 'rails', require: false"]
      )
    end

    it 'returns the gem definition with multiple options' do
      gem = ::WamlToRails::Sources::Gemfile::Gem.new(
        name: 'rails', required: false, group: :default, platforms: [:ruby, :jruby], version: '7.2.0'
      )

      expect(
        described_class.new(gem: gem).render
      ).to eq(
        [:default, "gem 'rails', '7.2.0', require: false, platforms: %i[ruby jruby]"]
      )
    end
  end
end
