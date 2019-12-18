# frozen_string_literal: true

describe TransferService do
  describe '#perfrom' do
    let(:withdraw_wallet) { create(:wallet, balance: 100) }
    let(:deposit_wallet) { create(:wallet) }

    it 'make transfer' do
      transfer = TransferService.new(withdraw_wallet: withdraw_wallet, deposit_wallet: deposit_wallet, amount: 100)

      expect { transfer.perform }.not_to raise_error
    end

    it 'raise validation error' do
      transfer = TransferService.new(withdraw_wallet: withdraw_wallet, deposit_wallet: deposit_wallet, amount: 150)

      expect { transfer.perform }.to raise_error(TransferValidationError)
    end
  end
end
