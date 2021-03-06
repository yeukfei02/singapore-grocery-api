# frozen_string_literal: true

require 'json'
require_relative '../../api/cold_storage_product'

def get_cold_storage_products(event:, context:)
  response = {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Credentials": true
    },
    body: {
      message: 'get_cold_storage_products'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    search_keyword = event['queryStringParameters']['search_keyword']
    page = event['queryStringParameters']['page']
    per_page = event['queryStringParameters']['per_page']
    order_by = event['queryStringParameters']['order_by'] || 'asc'

    products, page, per_page, max_page, query = cold_storage_products_request(search_keyword, page, per_page, order_by)

    response = {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true
      },
      body: {
        message: 'get_cold_storage_products',
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
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true
      },
      body: {
        message: 'get_cold_storage_products error, must have query params'
      }.to_json
    }
  end

  response
end
