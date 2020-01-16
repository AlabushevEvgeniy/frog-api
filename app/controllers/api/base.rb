module API
  # Root API class
  class Base < Grape::API
    format :json

    helpers API::Errors

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      bad_request!(message: 'Bad Request', errors: e.full_messages)
    end

    rescue_from(:all) do |e|
      server_error!(message: e.message, source: e.backtrace.first)
    end

    mount API::V1::Base => 'v1'
  end
end
