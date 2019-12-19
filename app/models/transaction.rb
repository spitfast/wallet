# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :deposit_wallet, class_name: 'Wallet'
  belongs_to :withdraw_wallet, class_name: 'Wallet'

  validate :available_balance, :self_transfer
  validates :deposit_wallet_id, :withdraw_wallet_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 100_000_0 }

  class << self
    def create_with_transfer!(args)
      transaction = create!(args)
      transaction.deposit_wallet.deposit(args[:amount])
      transaction.withdraw_wallet.withdraw(args[:amount])
      transaction
    end
  end

  private

  def self_transfer
    return unless deposit_wallet_id == withdraw_wallet_id

    errors.add(:withdraw_wallet_id, 'the deposit and withdraw wallets should be different')
  end

  def available_balance
    return unless withdraw_wallet.present? && amount.present?

    errors.add(:withdraw_wallet_id, 'not enough balance') if withdraw_wallet.balance < amount
  end
end
