# frozen_string_literal: true

require 'spec_helper'

describe API::V1::Transfers do
  context 'POST /api/v1/transfers' do
    let(:params) do
      { withdraw_wallet_id: create(:wallet, balance: 100).id,
        deposit_wallet_id: create(:wallet).id,
        amount: 20 }
    end

    it 'return invalid params' do
      post '/api/v1/transfers', params: {}

      expect(response.status).to eq(400)
    end

    it 'successfully create a transfer' do
      post '/api/v1/transfers', params: params

      expect(response.status).to eq(201)
      expect(response.body).to match_json_expression(success: true)
    end

    it 'return record invalid error' do
      post '/api/v1/transfers', params: params.update(withdraw_wallet_id: 666)

      expect(response.status).to eq(422)
      expect(response.body).to match_json_expression(error: 'Validation failed: Withdraw wallet must exist')
    end
  end
end
