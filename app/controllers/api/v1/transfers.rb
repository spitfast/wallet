# frozen_string_literal: true

module API
  module V1
    class Transfers < Grape::API
      include API::V1::Defaults

      resource :transfers do
        desc 'Make a transfer'
        params do
          requires :deposit_wallet_id, type: Integer
          requires :withdraw_wallet_id, type: Integer
          requires :amount, type: BigDecimal
        end
        post do
          TransferService.new(permitted_params).perform

          { success: true }
        end
      end
    end
  end
end
