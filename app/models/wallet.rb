# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :deposit_transactions, foreign_key: :deposit_wallet_id, class_name: 'Transaction',
                                  inverse_of: 'deposit_wallet'
  has_many :withdraw_transactions, foreign_key: :withdraw_wallet_id, class_name: 'Transaction',
                                   inverse_of: 'withdraw_wallet'
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 100_000_0 }

  def deposit(amount)
    lock!
    update!(balance: balance + amount)
  end

  def withdraw(amount)
    lock!
    update!(balance: balance - amount)
  end
end