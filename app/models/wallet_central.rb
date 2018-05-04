class WalletCentral < ApplicationRecord
  def self.transfer(from, to, currency, amount)
    user_to_transfer = User.find_by(name: from)
    wallet_to_transfer = user_to_transfer.has_wallet?(currency)
    return "#{from} must have a wallet with #{currency} currency" unless wallet_to_transfer
    user_to_receive = User.find_by(name: to)

    wallet_to_receive = if user_to_receive.has_wallet?(currency)
                          user_to_receive.wallets.find_by(currency: currency)
                        else
                          Wallet.create(currency: 'USD', amount_cents: 0, user_id: user_to_receive.id)
                          user_to_receive.wallets.find_by(currency: 'USD')
                        end
    if wallet_to_transfer.update(amount_cents: wallet_to_transfer.amount_cents - amount.to_d)
      old_currency = wallet_to_transfer.currency
      new_currency = wallet_to_receive.currency
      received_amount = if old_currency == new_currency
                          amount.to_d
                        else
                          convert(old_currency, new_currency, amount.to_d)
                        end
      wallet_to_receive.amount_cents += received_amount
      wallet_to_receive.save
    else
      return "#{from} doesnt have enought money to transfer"
    end
  end

  def self.convert(old_currency, new_currency, amount_cents)
    conversion_rate = Money.default_bank.get_rate(
      old_currency.to_sym, new_currency.to_sym
    )
    amount_cents * conversion_rate
  end
end
