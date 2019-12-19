# frozen_string_literal: true

module TransferHelper
  def create_transfer(params = {})
    withdraw_wallet = params.fetch(:withdraw_wallet, create(:wallet, balance: 100))
    deposit_wallet = params.fetch(:deposit_wallet, create(:wallet))
    TransferService.new(withdraw_wallet: withdraw_wallet, deposit_wallet: deposit_wallet, amount: params[:amount])
  end
end
