module API
  module V1
    module Private
      class User < Grape::API
        desc 'Return current user' do
          success model: API::V1::Entities::UserV1
        end
        get '/me' do
          present current_resource_owner, with: API::V1::Entities::UserV1
        end

        desc 'Return list of all users' do
          success model: API::V1::Entities::UserV1
        end
        get '/' do
          users = ::User.all
          present users, with: API::V1::Entities::UserV1
        end

        desc 'Get user by :id' do
          success model: API::V1::Entities::UserV1
        end
        params do
          requires :id, type: Integer
        end
        get '/:id' do
          user = ::User.find(permitted_params[:id])
          present user, with: API::V1::Entities::UserV1
        end

        desc 'Update current user' do
          success model: API::V1::Entities::UserV1
        end
        params do
          requires :user, type: Hash do
            optional :name, type: String
            optional :email, type: String
            optional :old_password, type: String
            optional :new_password, type: String
          end
        end
        put '/update' do
          if permitted_params.dig(:user, :old_password) && permitted_params.dig(:user, :new_password)
            if current_resource_owner.password == permitted_params.dig(:user, :old_password)
              current_resource_owner.assign_attributes(password: permitted_params(:user, :new_password))
            else
              error! 'Old password is incorrect'
            end
          elsif permitted_params.dig(:user, :new_password) && permitted_params.dig(:user, :old_password).nil?
            error! "Old password can't be blank"
          elsif permitted_params.dig(:user, :old_password) && permitted_params.dig(:user, :new_password).nil?
            error! "New password can't be blank"
          end

          current_resource_owner.assign_attributes(name: permitted_params.dig(:user, :name)) if permitted_params.dig(:user, :name)
          current_resource_owner.assign_attributes(email: permitted_params.dig(:user, :email)) if permitted_params.dig(:user, :email)

          if current_resource_owner.save! && permitted_params.dig(:user).blank?
            error! "There are no fileds for updating"
          else
            present present current_resource_owner, with: API::V1::Entities::UserV1
          end
        end
      end
    end
  end
end
