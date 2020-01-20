module API
  module V1
    module Public
      class Registration < Grape::API
        desc 'Create new user' do
          success model: API::V1::Entities::UserV1
        end
        params do
          requires :user, type: Hash do
            requires :name, type: String
            requires :email, type: String
            requires :password, type: String
          end
        end
        post '/' do
          user = ::User.new(permitted_params[:user])
          if user.save!
            present user, with: API::V1::Entities::UserV1
          else
            status 422
            present errors: user.errors.full_messages
          end
        end
      end
    end
  end
end
