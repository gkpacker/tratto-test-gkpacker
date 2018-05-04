json.array! @users do |user|
  json.extract! user, :name
  json.wallets user.wallets do |wallet|
    hash = { wallet.currency => wallet.amount_cents }
    json.merge! hash
  end
end
