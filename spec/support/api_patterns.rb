# frozen_string_literal: true

def wallets_pattern
  [{ id: Integer,
     walletable_id: Integer,
     balance: String,
     name: String }].ignore_extra_values!
end
