require 'rails_helper'
require 'spec_helper'

RSpec.describe WalletCentral do
  it "transfer money from one account to another" do
    user = User.create(name: 'Gabriel')
    receiver = User.create(name: 'Carolina')
    Wallet.create(currency: 'BRL', amount_cents: 200, user_id: user.id)
    Wallet.create(currency: 'USD', amount_cents: 0, user_id: receiver.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'BRL', 100)

    user_wallet = Wallet.find_by(user_id: user.id)

    expect(user_wallet.amount_cents.to_d).to eq 100.to_d
  end

  it "transfer money from one account to another without wallet" do
    user = User.create(name: 'Gabriel')
    receiver = User.create(name: 'Carolina')
    Wallet.create(currency: 'USD', amount_cents: 200, user_id: user.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'USD', 100)

    receiver_wallet = Wallet.find_by(user_id: receiver.id)
    expect(receiver_wallet.amount_cents.to_d).to eq 100.to_d
  end

  it "transfer money from EUR to USD" do
    user = User.create(name: 'Gabriel')
    receiver = User.create(name: 'Carolina')
    Wallet.create(currency: 'EUR', amount_cents: 200, user_id: user.id)
    Wallet.create(currency: 'USD', amount_cents: 0, user_id: receiver.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'EUR', 100)

    user_wallet = Wallet.find_by(user_id: user.id)

    expect(user_wallet.amount_cents.to_d).to eq 100.to_d
  end
end
