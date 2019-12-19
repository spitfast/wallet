# frozen_string_literal: true

module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v1', using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error_response(message: e.message, status: 400)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end

        rescue_from :all do |e|
          error_response(message: e.message, status: 500)
        end
      end
    end
  end
end
