# frozen_string_literal: true

class Stock < ApplicationRecord
  include Walletable

  validates :name, presence: true
end
