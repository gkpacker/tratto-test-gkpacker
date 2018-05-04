require 'rails_helper'
require 'spec_helper'

RSpec.describe WalletCentral do

  setup do
    @user = User.create(name: 'Gabriel')
    @receiver = User.create(name: 'Carolina')
  end
  it "transfer money to existing wallet" do
    Wallet.create(currency: 'BRL', amount_cents: 200, user_id: @user.id)
    Wallet.create(currency: 'BRL', amount_cents: 0, user_id: @receiver.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'BRL', 100)

    user_wallet = Wallet.find_by(user_id: @user.id)

    expect(user_wallet.amount_cents.to_d).to eq 100.to_d
  end


  it "transfer money to an account without wallet" do
    Wallet.create(currency: 'USD', amount_cents: 200, user_id: @user.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'USD', 100)
    receiver_wallet = Wallet.find_by(user_id: @receiver.id)

    expect(receiver_wallet.currency).to eq 'USD'
  end

  it "transfer money to an account and transfer back" do
    Wallet.create(currency: 'USD', amount_cents: 200.35, user_id: @user.id)
    Wallet.create(currency: 'USD', amount_cents: 0, user_id: @receiver.id)

    WalletCentral.transfer('Gabriel', 'Carolina', 'USD', 100.35)
    WalletCentral.transfer('Carolina', 'Gabriel', 'USD', 100.35)
    user_wallet = Wallet.find_by(user_id: @user.id)

    expect(user_wallet.amount_cents.to_d).to eq 200.35.to_d

  end

  it 'not valid when doesnt have a wallet in currency' do
    Wallet.create(currency: 'BRL', amount_cents: 200, user_id: @user.id)
    Wallet.create(currency: 'USD', amount_cents: 0, user_id: @receiver.id)


    expect(WalletCentral.transfer('Gabriel', 'Carolina', 'EUR', 100)).to eq "Gabriel must have a wallet with EUR currency"
  end

  it 'not valid when doesnt have enought money to transfer' do
    Wallet.create(currency: 'BRL', amount_cents: 200, user_id: @user.id)
    Wallet.create(currency: 'BRL', amount_cents: 0, user_id: @receiver.id)


    expect(WalletCentral.transfer('Gabriel', 'Carolina', 'BRL', 300)).to eq "Gabriel doesnt have enought money to transfer"
  end
end
