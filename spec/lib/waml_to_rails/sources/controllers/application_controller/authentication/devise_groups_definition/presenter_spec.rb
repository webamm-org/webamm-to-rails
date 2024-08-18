require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::ApplicationController::Authentication::DeviseGroupsDefinition::Presenter do
  describe '#collection' do
    it 'returns a collection of devise groups' do
      devise_mappings = {
        ['users'] => 'users',
        ['admins'] => 'admins',
        ['users', 'admins'] => 'group1',
        ['users', 'admins', 'super_admins'] => 'group2'
      }

      expect(
        described_class.new(devise_mappings: devise_mappings).collection
      ).to eq(
        [
          'devise_group :group1, contains: [:user, :admin]',
          'devise_group :group2, contains: [:user, :admin, :super_admin]'
        ]
      )
    end
  end
end
