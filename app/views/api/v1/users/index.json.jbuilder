json.array! @users do |user|
  json.extract! user, :name
  json.wallets user.wallets do |wallet|
    json.extract! wallet, :currency, :amount
  end
end
