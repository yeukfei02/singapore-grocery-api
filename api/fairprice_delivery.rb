# frozen_string_literal: true

require 'faraday'

def fair_price_delivery_request(postal_code)
  delivery_result = {}

  conn = request_base
  response = conn.get('/address/search') do |req|
    req.params['term'] = postal_code
  end

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)

    delivery_result = response_body['data'] if response_body['data']
  end

  delivery_result
end

def request_base
  Faraday.new(
    url: 'https://public-api.omni.fairprice.com.sg',
    headers: { 'Content-Type': 'application/json' }
  )
end
