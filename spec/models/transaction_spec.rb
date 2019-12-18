# frozen_string_literal: true

require 'spec_helper'

describe Transaction do
  let(:withdraw_wallet) { build_stubbed(:wallet, balance: 100) }
  let(:deposit_wallet) { build_stubbed(:wallet) }

  describe 'validations' do
    describe 'amount' do
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount).is_greater_than(0).is_less_than(100_000_0) }
    end

    describe 'wallets' do
      it { should validate_presence_of(:deposit_wallet_id) }
      it { should validate_presence_of(:withdraw_wallet_id) }
    end

    describe '#self_transfer' do
      let(:wallet) { build_stubbed(:wallet) }

      it 'do not allow transfer between same wallets' do
        record = Transaction.create(amount: 10, deposit_wallet: wallet, withdraw_wallet: wallet)
        expect = 'the deposit and withdraw wallets should be different'

        expect(record.errors.messages[:withdraw_wallet_id]).to include(expect)
      end
    end

    describe '#available_balance' do
      it 'do not allow transfer if not enough balance' do
        record = Transaction.create(amount: 101, deposit_wallet: deposit_wallet, withdraw_wallet: withdraw_wallet)

        expect(record.errors.messages[:withdraw_wallet_id]).to include('not enough balance')
      end
    end
  end

  describe 'valid transaction' do
    it 'create a transaction' do
      record = Transaction.create(amount: 50, deposit_wallet: deposit_wallet, withdraw_wallet: withdraw_wallet)

      expect(record).to be_valid
    end
  end

  describe '#create_with_transfer!' do
    it 'create transaction + make transfer' do
      record = Transaction.create_with_transfer!(amount: 50, deposit_wallet: create(:wallet),
                                                 withdraw_wallet: create(:wallet, balance: 100))

      expect(record.amount).to eq(BigDecimal(50))
      expect(record.deposit_wallet.balance).to eq(BigDecimal(150))
      expect(record.withdraw_wallet.balance).to eq(BigDecimal(50))
    end
  end
end
