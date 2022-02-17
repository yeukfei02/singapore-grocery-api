# frozen_string_literal: true

require 'json'
require_relative '../../api/fairprice_delivery'

def get_fair_price_delivery(event:, context:)
  response = {
    statusCode: 200,
    body: {
      message: 'get_fair_price_delivery'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    postal_code = event['queryStringParameters']['postal_code']

    delivery = fair_price_delivery_request(postal_code)

    response = {
      statusCode: 200,
      body: {
        message: 'get_fair_price_delivery',
        delivery: delivery
      }.to_json
    }
  else
    response = {
      statusCode: 400,
      body: {
        message: 'get_fair_price_delivery error, must have query params'
      }.to_json
    }
  end

  response
end
