require 'spec_helper'

RSpec.describe WebammToRails::Sources::Controllers::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'users',
        actions: []
      )

      waml_definition = Webamm::Definition.new(
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
      crud_definition = Webamm::Database::Crud.new(
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

      waml_definition = Webamm::Definition.new(
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
          def index
            @users = User.all
          end

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

            redirect_to users_path, notice: "User was successfully destroyed."
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

    it 'renders basic CRUD controller with devise authentication' do
      crud_definition = Webamm::Database::Crud.new(
        table: 'users',
        actions: [
          {
            name: 'index',
            options: {
              authentication: ['users']
            }
          },
          {
            name: 'show',
            options: {
              authentication: ['users']
            }
          },
          {
            name: 'create',
            options: {
              authentication: ['admins']
            }
          },
          {
            name: 'update',
            options: {
              authentication: ['admins']
            }
          },
          {
            name: 'destroy',
            options: {
              authentication: ['users', 'admins']
            }
          }
        ]
      )

      waml_definition = Webamm::Definition.new(
        authentication: [
          {
            table: 'users',
            features: []
          },
          {
            table: 'admins',
            features: []
          }
        ],
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
          before_action :authenticate_user!, only: [:index, :show]
          before_action :authenticate_admin!, only: [:create, :new, :update, :edit]
          before_action :authenticate_group1!, only: [:destroy]

          def index
            @users = User.all
          end

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

            redirect_to users_path, notice: "User was successfully destroyed."
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
