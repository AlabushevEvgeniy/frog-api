require 'doorkeeper/grape/helpers'

module API
  module V1
    class Base < Grape::API
      include API::Defaults
      include API::Authenticable

      helpers Doorkeeper::Grape::Helpers

      namespace do
        before {doorkeeper_authorize!}

        mount API::V1::Private::User => 'users'
      end

      namespace do
        mount API::V1::Public::Registration => 'registrations'
      end
    end
  end
end
