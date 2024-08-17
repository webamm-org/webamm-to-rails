require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::DestroyDefinition::Presenter do
  describe '#render?' do
    it 'returns true if destroy action is present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'show',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render?
      ).to eq(true)
    end

    it 'returns false if destroy action is not present' do
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
            name: 'index',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def destroy
          @user = User.find(params[:id])
          @user.destroy!

          redirect_to users_path
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end

    it 'renders the action when index action is not present' do
      crud_definition = ::Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'destroy',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def destroy
          @user = User.find(params[:id])
          @user.destroy!

          redirect_to root_path
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
