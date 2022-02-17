# frozen_string_literal: true

require 'json'
require_relative '../../api/giant'

def get_giant_products(event:, context:)
  response = {
    statusCode: 200,
    body: {
      message: 'get_giant_products'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    search_keyword = event['queryStringParameters']['search_keyword']
    page = event['queryStringParameters']['page']
    per_page = event['queryStringParameters']['per_page']

    products, page, per_page, max_page, query = giant_products_request(search_keyword, page, per_page)

    response = {
      statusCode: 200,
      body: {
        message: 'get_giant_products',
        products: products,
        page: page,
        per_page: per_page,
        max_page: max_page,
        query: query
      }.to_json
    }
  else
    response = {
      statusCode: 400,
      body: {
        message: 'get_giant_products error, must have query params'
      }.to_json
    }
  end

  response
end
