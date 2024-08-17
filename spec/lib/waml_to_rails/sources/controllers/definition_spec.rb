require 'spec_helper'

RSpec.describe WamlToRails::Sources::Controllers::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        class UsersController < ApplicationController
        end
      RUBY

      expect(
        described_class.new(crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
