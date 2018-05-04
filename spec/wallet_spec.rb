require 'rails_helper'
require 'spec_helper'

RSpec.describe Wallet, type: :model do
  it "is valid with valid attributes" do
    user = User.create(name: "Roberto")
    wallet = Wallet.create(currency: 'BRL', amount_cents: 200, user_id: user.id)
    expect(wallet).to be_valid
  end

  it "is valid without a amount_cents" do
    user = User.create(name: "Roberto")
    wallet = Wallet.create(currency: 'USD', user_id: user.id)
    expect(wallet).to be_valid
  end

  it "is not valid without a currency" do
    user = User.create(name: "Roberto")
    wallet = Wallet.create(amount_cents: 200, user_id: user.id)
    expect(wallet).to_not be_valid
  end

  it "is not valid without a user_id" do
    user = User.create(name: "Roberto")
    wallet = Wallet.create(currency: 'USD', amount_cents: 200)
    expect(wallet).to_not be_valid
  end

end
