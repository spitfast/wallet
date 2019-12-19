# frozen_string_literal: true

require 'spec_helper'

describe API::V1::Wallets do
  context 'GET /api/v1/wallets' do
    it 'returns array of wallets' do
      get '/api/v1/wallets'

      expect(response.status).to eq(200)
      expect(response.body).to match_json_expression(wallets_pattern)
    end
  end
end
