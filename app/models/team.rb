# frozen_string_literal: true

class Team < ApplicationRecord
  include Walletable

  validates :name, presence: true
end
