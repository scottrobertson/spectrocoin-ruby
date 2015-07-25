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
      signature = private_key.sign(OpenSSL::Digest::SHA1.new, signature_data(data))
      Base64.encode64(signature)
    end

    def validate_signature(data, signature)
      signature = Base64.decode64(signature)
      private_key = OpenSSL::PKey::read(File.read(@private_key))
      private_key.public_key.verify(OpenSSL::Digest::SHA1.new, signature, signature_data(data))
    end

    private

    def signature_data(data)
      data.to_a.map { |x| "#{x[0]}=#{prepare_value(x[1])}" }.join("&")
    end

    def prepare_value(value)
      return CGI.escape(value) if value.is_a?(String)
      value
    end
  end
end
