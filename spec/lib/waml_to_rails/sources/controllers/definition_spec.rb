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

      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [],
          crud: [crud_definition]
        }
      )

      expected_definition = <<~RUBY
        class UsersController < ApplicationController
        end
      RUBY

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end

    it 'renders basic CRUD controller' do
      crud_definition = Waml::Definition::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {}
          },
          {
            name: 'show',
            options: {}
          },
          {
            name: 'create',
            options: {}
          },
          {
            name: 'update',
            options: {}
          },
          {
            name: 'destroy',
            options: {}
          },
          {
            name: 'new',
            options: {}
          },
          {
            name: 'edit',
            options: {}
          }
        ]
      )

      waml_definition = Waml::Definition.new(
        authentication: [],
        database: {
          engine: 'postgresql',
          relationships: [],
          schema: [
            {
              table: 'users',
              indices: [],
              columns: [
                {
                  name: 'first_name',
                  type: 'string',
                  default: nil,
                  null: true
                },
                {
                  name: 'last_name',
                  type: 'string',
                  default: nil,
                  null: true
                }
              ]
            }
          ],
          crud: [crud_definition]
        }
      )

      expected_definition = <<~RUBY
        class UsersController < ApplicationController
          def new
            @user = User.new
          end

          def edit
            @user = User.find(params[:id])
          end

          def show
            @user = User.find(params[:id])
          end

          def destroy
            @user = User.find(params[:id])
            @user.destroy!

            redirect_to users_path
          end

          def create
            @user = User.new(user_params)

            if @user.save
              redirect_to users_path
            else
              render :new, status: :unprocessable_entity
            end
          end

          def update
            @user = User.find(params[:id])

            if @user.update(user_params)
              redirect_to users_path
            else
              render :edit, status: :unprocessable_entity
            end
          end

          private

          def user_params
            params.require(:user).permit(:first_name, :last_name)
          end
        end
      RUBY

      expect(
        described_class.new(crud_definition: crud_definition, waml_definition: waml_definition).render
      ).to eq(expected_definition)
    end
  end
end
