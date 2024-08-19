require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Controllers::Actions::IndexDefinition::Presenter do
  describe '#render?' do
    it 'returns true if index action is present' do
      crud_definition = ::Webamm::Database::Crud.new(
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
      ).to eq(true)
    end

    it 'returns false if index action is not present' do
      crud_definition = ::Webamm::Database::Crud.new(
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
      crud_definition = ::Webamm::Database::Crud.new(
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
        def index
          @users = User.all
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
