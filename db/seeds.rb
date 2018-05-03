require 'csv'
puts "Cleaning Database..."
User.destroy_all
Wallet.destroy_all

puts "Creating users and wallets"
  CSV.foreach("lib/resources/wallets.csv", headers: true) do |row|
    User.create(name: row[0])
    user = User.find_by(name: row[0])
    Wallet.create!(currency: row[1], amount: row[2].to_i, user_id: user.id)
  end
puts "created #{User.count} users and #{Wallet.count} wallets"
puts "Done"
