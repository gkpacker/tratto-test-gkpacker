class AddCurrencyToWallets < ActiveRecord::Migration[5.1]
  def change
    add_column :wallets, :currency, :string
  end
end
