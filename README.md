# Spectrocoin

Ruby client for spectrocoin.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spectrocoin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spectrocoin

## Usage

### Generate SSL Certificates
```
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -pubout -outform PEM -out public.pem
```

### Create order

```ruby
order = Spectrocoin::Order.new(6030, 34713, 'certs/private.pem', 'certs/public.pem')
response = order.create('BTC', 1, callback_url: 'https://example.com/callback')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/scottrobertson/spectrocoin-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
