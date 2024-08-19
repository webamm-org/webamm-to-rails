require 'spec_helper'

RSpec.describe WebammToRails::Sources::Gemfile::Gem do
  it 'provides gem interface' do
    gem = described_class.new(
      name: 'devise',
      version: '5.0.0',
      required: false,
      group: :development,
      platforms: [:jruby]
    )

    expect(gem.name).to eq('devise')
    expect(gem.version).to eq('5.0.0')
    expect(gem.required).to eq(false)
    expect(gem.group).to eq(:development)
    expect(gem.platforms).to eq([:jruby])
  end
end
