require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::DestroyDefinition::Presenter do
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
