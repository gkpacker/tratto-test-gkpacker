class User < ApplicationRecord
  has_many :wallets
  validates :name, presence: true
end
