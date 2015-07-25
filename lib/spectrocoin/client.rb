require "rubygems"
require "bundler/setup"
require 'api_client'
require 'openssl'
require 'base64'

module Spectrocoin
  class Client < ApiClient::Base

    attr_accessor :merchant_id, :api_id

    always do
      endpoint "https://spectrocoin.com/"
    end

    def initialize(merchant_id, api_id, private_key, public_key)
      @merchant_id = merchant_id
      @api_id = api_id
      @private_key = private_key
      @public_key = public_key
    end

    def generate_signature(data)
      private_key = OpenSSL::PKey::read(File.read(@private_key))
      signature = private_key.sign(OpenSSL::Digest::SHA1.new, data.to_s)
      Base64.encode64(signature)
    end

    def validate_signature(data, signature)
      signature = Base64.decode64(signature)
      private_key = OpenSSL::PKey::read(File.read(@private_key))
      private_key.public_key.verify(OpenSSL::Digest::SHA1.new, signature, data.to_s)
    end
  end
end
