# frozen_string_literal: true

require 'json'
require_relative '../../api/cold_storage_delivery'

def get_cold_storage_delivery(event:, context:)
  response = {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Credentials": true
    },
    body: {
      message: 'get_cold_storage_delivery'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    postal_code = event['queryStringParameters']['postal_code']

    delivery = cold_storage_delivery_request(postal_code)

    response = {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true
      },
      body: {
        message: 'get_cold_storage_delivery',
        delivery: delivery
      }.to_json
    }
  else
    response = {
      statusCode: 400,
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true
      },
      body: {
        message: 'get_cold_storage_delivery error, must have query params'
      }.to_json
    }
  end

  response
end
