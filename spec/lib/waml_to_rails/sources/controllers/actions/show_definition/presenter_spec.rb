require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::ShowDefinition::Presenter do
  describe '#render?' do
    it 'returns true if show action is present' do
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
      ).to eq(true)
    end

    it 'returns false if show action is not present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'edit',
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
        def show
          @user = User.find(params[:id])
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
