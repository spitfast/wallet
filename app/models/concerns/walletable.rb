# frozen_string_literal: true

module Walletable
  extend ActiveSupport::Concern

  included do
    has_one :wallet, as: :walletable

    after_create :init_wallet
  end

  private

  def init_wallet
    create_wallet!(balance: 0)
  end
end
