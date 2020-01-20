require 'grape-swagger'
require 'doorkeeper/grape/helpers'

module API
  module V1
    class Base < Grape::API
      include API::Defaults
      include API::Authenticable

      helpers Doorkeeper::Grape::Helpers

      # format :json
      namespace do
        before {doorkeeper_authorize!}

        mount API::V1::User => 'users'
      end

      add_swagger_documentation(
        api_version: 'v1',
        base_path: '/api/v1',
        hide_documentation_path: true,
        hide_format: true
      )
    end
  end
end
