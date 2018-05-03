class CreateWalletCentrals < ActiveRecord::Migration[5.1]
  def change
    create_table :wallet_centrals do |t|

      t.timestamps
    end
  end
end
