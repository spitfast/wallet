# frozen_string_literal: true

module API
  module V1
    class Wallets < Grape::API
      include API::V1::Defaults

      resources :wallets do
        desc 'Return all wallets'
        get do
          present Wallet.all, with: API::V1::Entities::Wallet::Base
        end
      end
    end
  end
end
