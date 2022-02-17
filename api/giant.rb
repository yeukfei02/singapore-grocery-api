# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require 'faraday'

def giant_products_request(search_keyword, page = '0', per_page = '20')
  products_result = []
  page_result = 0
  per_page_result = 20
  max_page_result = 0
  query_result = ''

  conn = request_base
  response = conn.post('/1/indexes/*/queries') do |req|
    req.body = {
      "requests": [
        {
          "indexName": 'giant_product_live',
          "params": "query=#{search_keyword}&hitsPerPage=#{per_page}&page=#{page}&clickAnalytics=true&facets=%5B%5D&tagFilters="
        }
      ]
    }.to_json
  end

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)
    products_response = response_body['results'][0]['hits']
    page_response = response_body['results'][0]['page']
    per_page_response = response_body['results'][0]['hitsPerPage']
    max_page_response = response_body['results'][0]['nbPages']
    query_response = response_body['results'][0]['query']

    products_result = products_response
    page_result = page_response
    per_page_result = per_page_response
    max_page_result = max_page_response
    query_result = query_response
  end

  [products_result, page_result, per_page_result, max_page_result, query_result]
end

def request_base
  Faraday.new(
    url: 'https://pfchi1ym66-dsn.algolia.net',
    params: {
      "x-algolia-application-id": ENV['X_ALGOLIA_APPLICATION_ID'],
      "x-algolia-api-key": ENV['X_ALGOLIA_API_KEY']
    },
    headers: { 'Content-Type': 'application/json' }
  )
end
