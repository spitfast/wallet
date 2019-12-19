# frozen_string_literal: true

require 'spec_helper'

describe TransferService do
  describe '#perfrom' do
    it 'make transfer' do
      expect { create_transfer(amount: 100).perform }.not_to raise_error
    end

    it 'raise validation error' do
      expect { create_transfer(amount: 150).perform }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#concurrency' do
    fixtures :wallets, :users
    let(:deposit_wallet) { wallets(:wallet) }
    let(:withdraw_wallet) { wallets(:rich_wallet) }

    it 'properly work with transfers' do
      transfer = create_transfer(amount: 10, deposit_wallet: deposit_wallet, withdraw_wallet: withdraw_wallet)

      make_concurrent_calls(transfer, :perform)

      expect(withdraw_wallet.reload.balance).to eq(BigDecimal(480))
      expect(deposit_wallet.reload.balance).to eq(BigDecimal(70))
    end
  end
end
