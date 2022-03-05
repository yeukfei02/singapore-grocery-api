# frozen_string_literal: true

require 'faraday'

def suggestions_request(search_keyword)
  suggestions_result = []

  conn = request_base
  response = conn.get('') do |req|
    req.params['text'] = search_keyword
  end

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)
    response_body_data = response_body['data']

    if !response_body_data.nil? && !response_body_data.empty?
      suggestions_list = response_body_data['suggestions']
      suggestions_result = suggestions_list.map do |suggestion|
        name = suggestion['name']
        name
      end
    end
  end

  suggestions_result
end

def request_base
  Faraday.new(
    url: 'https://website-api.omni.fairprice.com.sg/api/suggestions',
    headers: { 'Content-Type': 'application/json' }
  )
end
