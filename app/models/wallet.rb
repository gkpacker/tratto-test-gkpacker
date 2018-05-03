class Wallet < ApplicationRecord
  belongs_to :user
  monetize :amount_cents
  validates :currency, presence: true, uniqueness: { scope: :user }
  validates :amount_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
