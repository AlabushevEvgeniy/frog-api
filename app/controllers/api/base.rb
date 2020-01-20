module API
  class Base < Grape::API
    # format :json

    helpers API::Errors

    mount API::V1::Base => 'v1'
  end
end
