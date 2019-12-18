class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true
      t.decimal :balance, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
