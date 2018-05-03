class AddAmountToWallets < ActiveRecord::Migration[5.1]
  def change
    add_column :wallets, :amount, :integer, limit: 8
  end
end
