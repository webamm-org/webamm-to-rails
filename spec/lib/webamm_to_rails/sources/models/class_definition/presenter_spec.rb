require 'spec_helper'

RSpec.describe WebammToRails::Sources::Models::ClassDefinition::Presenter do
  subject { described_class.new(table_name: 'users') }

  it 'renders the class definition' do
    expect(subject.render).to eq('class User < ApplicationRecord')
  end

  it 'renders the class definition with a custom base class' do
    expect(subject.render(base_class: 'BaseRecord')).to eq('class User < BaseRecord')
  end

  it 'renders the class definition with more complex table name' do
    expect(
      described_class.new(table_name: 'user_profiles').render
    ).to eq('class UserProfile < ApplicationRecord')
  end
end
