require 'wallet_central'

RSpec.describe WalletCentral do
  it "transfer money from one account to another without wallet" do
    user = User.create(name: 'Gabriel')
    receiver = User.create(name: 'Carol')
    Wallet.create(currency: 'USD', amount: 202.23, user_id: user.id)

    WalletCentral.transfer('Gabriel', 'Carol', 'USD', 102.23)

    expect(order.total).to eq(Money.new(5.55, :USD))
  end
end
