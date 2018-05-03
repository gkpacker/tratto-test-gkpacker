class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.decimal "amount", precision: 8, scale: 2

      t.timestamps
    end
  end
end
