require 'csv'
CSV.foreach("lib/resources/wallets.csv") do |row|
  puts row
end
