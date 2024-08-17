require 'spec_helper'

RSpec.describe WamlToRails::Sources::Controllers::ClassDefinition::Presenter do
  subject { described_class.new(table_name: 'users') }

  it 'renders the class definition' do
    expect(subject.render).to eq('class UsersController < ApplicationController')
  end

  it 'renders the class definition with a custom base class' do
    expect(subject.render(base_class: 'BaseController')).to eq('class UsersController < BaseController')
  end

  it 'renders the class definition with more complex table name' do
    expect(
      described_class.new(table_name: 'user_profiles').render
    ).to eq('class UserProfilesController < ApplicationController')
  end
end
