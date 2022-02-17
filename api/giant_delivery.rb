# frozen_string_literal: true

require 'faraday'

def giant_delivery_request(postal_code)
  delivery_result = {}

  conn = request_base
  response = conn.post('') do |req|
    req.body = { 'is_process': '1', 'selection': 'normal', 'postal_code': postal_code }.to_json
  end
  puts "response.status = #{response.status}"
  puts "response.body = #{response.body}"

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)

    delivery_result = response_body if response_body
  end

  delivery_result
end

def request_base
  Faraday.new(
    url: 'https://giant.sg/checkout/fulfilment/simpleselection',
    headers: { 'Content-Type': 'application/json' }
  )
end
