require 'yaml'

module Spectrocoin
  class Order
    def initialize(client, currency, amount, order_id: nil, description: nil, culture: nil, callback_url: nil, success_url: nil, failure_url: nil)
      @client = client
      @order_data = {
        merchantId: @client.merchant_id,
        apiId: @client.api_id,
        orderId: order_id,
        payCurrency: currency,
        receiveAmount: amount,
        description: description,
        culture: culture,
        callbackUrl: callback_url,
        successUrl: success_url,
        failureUrl: failure_url
      }

      @order_data[:sign] = @client.generate_signature(@order_data)
    end

    def create
      response = @client.class.post("/api/merchant/1/createOrder", @order_data)

      if response.is_a?(Array)
        raise response.to_yaml
      end

      response
    end
  end
end
