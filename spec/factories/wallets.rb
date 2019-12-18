# frozen_string_literal: true

FactoryBot.define do
  factory :wallet do
    association :walletable, factory: :user
    balance { 100 }
  end
end
