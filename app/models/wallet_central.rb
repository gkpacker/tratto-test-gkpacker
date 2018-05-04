class WalletCentral < ApplicationRecord
  def self.transfer(from, to, currency, amount)
    owner = User.find_by(name: from)
    receiver = User.find_by(name: to)
    owner_wallet = owner.has_wallet?(currency)
    receiver_wallet = set_receiver_wallet(receiver, currency)

    return "#{from} must have a wallet with #{currency} currency" unless owner_wallet
    return "#{to} must have a wallet" unless receiver_wallet

    if owner_wallet.update(amount_cents: owner_wallet.amount_cents - amount.to_d)
      received_amount = set_received_amount(owner_wallet, receiver_wallet, amount)
      receiver_wallet.amount_cents += received_amount
      receiver_wallet.save
    else
      return "#{from} doesnt have enought money to transfer"
    end
  end

  private

  def self.set_receiver_wallet(receiver, currency)
    if receiver.has_wallet?(currency)
      receiver.wallets.find_by(currency: currency)
    else
      receiver.wallets.last
    end
  end

  def self.convert(old_currency, new_currency, amount_cents)
    conversion_rate = Money.default_bank.get_rate(
      old_currency.to_sym, new_currency.to_sym
    )
    amount_cents * conversion_rate
  end

  def self.set_received_amount(owner_wallet, receiver_wallet, amount)
    return amount.to_d if owner_wallet.currency == receiver_wallet.currency
    convert(old_currency, new_currency, amount.to_d)
  end
end
