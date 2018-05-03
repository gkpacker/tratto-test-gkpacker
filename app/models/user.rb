class User < ApplicationRecord
  has_many :wallets
  validates :name, presence: true, uniqueness: true

  def has_wallet?(currency)
    wallets.find_by(currency: currency)
  end
end
