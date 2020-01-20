module API
  module V1
    class User < Grape::API
      include API::Defaults

      desc 'Return current user' do
        success model: API::V1::Entities::UserV1
      end

      get '/me' do
        # binding.pry
        present current_resource_owner, with: API::V1::Entities::UserV1
      end
    end
  end
end
