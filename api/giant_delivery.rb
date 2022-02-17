# frozen_string_literal: true

require 'faraday'

def giant_delivery_request(postal_code)
  delivery_result = {}

  conn = request_base
  response = conn.post('post', 'is_process': '1', 'selection': 'normal', 'postal_code': postal_code)

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)

    delivery_result = response_body if response_body
  end

  delivery_result
end

def request_base
  Faraday.new(
    url: 'https://giant.sg/checkout/fulfilment/simpleselection'
  )
end
