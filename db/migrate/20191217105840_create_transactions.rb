class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.references :deposit_wallet, index: true
      t.references :withdraw_wallet, index: true

      t.timestamps
    end
  end
end
