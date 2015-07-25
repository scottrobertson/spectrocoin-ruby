require 'yaml'
require 'spectrocoin'

client = Spectrocoin::Client.new(6030, 34713, 'certs/private.pem', 'certs/public.pem')
order = Spectrocoin::Order.new(client, 'BTC', 1, callback_url: 'https://example.com/callback')
response = order.create

puts response.to_yaml
