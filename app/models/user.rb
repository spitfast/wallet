# frozen_string_literal: true

class User < ApplicationRecord
  include Walletable

  validates :name, presence: true
end
