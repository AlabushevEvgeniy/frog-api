module API
  module Authenticable
    extend ActiveSupport::Concern

    included do
      helpers do
        def current_resource_owner
          if doorkeeper_token
            @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id)
          end
        end

        def current_user
          current_resource_owner
        end
      end
    end
  end
end
