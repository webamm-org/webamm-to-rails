require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::EditDefinition::Presenter do
  describe '#render?' do
    it 'returns true if update action is present' do
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

    it 'returns false if update action is not present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          },
          {
            name: 'index',
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
            name: 'index',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def edit
          @user = User.find(params[:id])
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
