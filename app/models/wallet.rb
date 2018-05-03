class Wallet < ApplicationRecord
  belongs_to :user
  monetize :amount_cents
  monetize :total_cents
  def total_cents
    puts amount_cents.to_digits
  end
end
