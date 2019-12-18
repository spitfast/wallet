# frozen_string_literal: true

require 'spec_helper'

describe Wallet do
  describe 'validations' do
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0).is_less_than(100_000_0) }
    it { should_not allow_values('string', nil).for(:balance) }
  end

  describe 'associations' do
    subject { build(:wallet) }

    it { expect(subject).to belong_to(:walletable) }
    it { expect(subject).to have_many(:deposit_transactions) }
  end

  describe 'callbacks' do
    subject { build(:user) }

    describe '#init_wallet' do
      it { expect(subject).to callback(:init_wallet).after(:create) }

      it 'create a wallet' do
        subject.save!

        expect(subject.wallet.walletable_type).to eq('User')
        expect(subject.wallet.walletable_id).to eq(subject.id)
        expect(subject.wallet.balance).to eq(BigDecimal(0))
      end
    end
  end

  describe 'deposit/withdraw locks' do
    fixtures :wallets, :users

    let(:deposit_wallet) { wallets(:wallet)}
    let(:withdraw_wallet) { wallets(:wallet)}

    it 'properly deposit balance' do
      make_concurrent_calls(deposit_wallet, :deposit, 100)

      expect(deposit_wallet.reload.balance).to eq(BigDecimal(250))
    end

    it 'properly withdraw balance' do
      make_concurrent_calls(withdraw_wallet, :withdraw, 10)

      expect(withdraw_wallet.reload.balance).to eq(BigDecimal(30))
    end
  end
end
