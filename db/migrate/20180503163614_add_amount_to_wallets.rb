class AddAmountToWallets < ActiveRecord::Migration[5.1]
  def change
    add_column :wallets, :amount_cents, :decimal, precision: 8, scale: 2, default: 0
  end
end
