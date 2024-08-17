require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::NewDefinition::Presenter do
  describe '#render?' do
    it 'returns true if create action is present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          },
          {
            name: 'create',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render?
      ).to eq(true)
    end

    it 'returns false if create action is not present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          },
          {
            name: 'update',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render?
      ).to eq(false)
    end
  end

  describe '#render' do
    it 'renders the action' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          },
          {
            name: 'update',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def new
          @user = User.new
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
