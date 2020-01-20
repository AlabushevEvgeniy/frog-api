module API
  module Defaults
    extend ActiveSupport::Concern

    included do
      # prefix "api"
      # version "v1", using: :path
      default_format :json
      format :json
      # formatter :json,
      #      Grape::Formatter::ActiveModelSerializers

      helpers do
        def permitted_params
          @permitted_params ||= declared(params, include_missing: false)
        end

        def logger
          Rails.logger
        end
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error_response(message: e.message, status: 422)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        bad_request!(message: 'Bad Request', errors: e.full_messages)
      end

      rescue_from(:all) do |e|
        server_error!(message: e.message, source: e.backtrace.first)
      end
    end
  end
end
