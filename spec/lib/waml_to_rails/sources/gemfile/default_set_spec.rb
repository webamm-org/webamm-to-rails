require 'spec_helper'

RSpec.describe WamlToRails::Sources::Gemfile::DefaultSet do
  it 'returns default set of gems' do
    expect(described_class::GEMS.size).to eq(16)

    rails_gem = described_class::GEMS.find { |gem| gem.name == 'rails' }

    expect(rails_gem.name).to eq('rails')
    expect(rails_gem.version).to eq('~> 7.2.0')
  end
end
