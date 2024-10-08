require 'spec_helper'

RSpec.describe ::WebammToRails::Sources::Controllers::Actions::CreateDefinition::Presenter do
  describe '#render?' do
    it 'returns true if create action is present' do
      crud_definition = ::Webamm::Database::Crud.new(
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
            name: 'create',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def create
          @user = User.new(user_params)

          if @user.save
            redirect_to user_path(@user)
          else
            render :new, status: :unprocessable_entity
          end
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end

    it 'renders the action when show action is not present but index is' do
      crud_definition = ::Webamm::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def create
          @user = User.new(user_params)

          if @user.save
            redirect_to users_path
          else
            render :new, status: :unprocessable_entity
          end
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end

    it 'renders the action when show and index actions are not present' do
      crud_definition = ::Webamm::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'create',
            options: {}
          }
        ]
      )

      expected_definition = <<~RUBY
        def create
          @user = User.new(user_params)

          if @user.save
            redirect_to root_path
          else
            render :new, status: :unprocessable_entity
          end
        end
      RUBY

      expect(
        described_class.new(table_name: 'users', crud_definition: crud_definition).render
      ).to eq(expected_definition)
    end
  end
end
