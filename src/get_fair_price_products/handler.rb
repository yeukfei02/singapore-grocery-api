# frozen_string_literal: true

require 'json'
require_relative '../../api/fairprice_product'

def get_fair_price_products(event:, context:)
  response = {
    statusCode: 200,
    body: {
      message: 'get_fair_price_products'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    search_keyword = event['queryStringParameters']['search_keyword']
    page = event['queryStringParameters']['page']
    order_by = event['queryStringParameters']['order_by'] || 'asc'

    products, page, per_page, max_page, query = fair_price_products_request(search_keyword, page, order_by)

    response = {
      statusCode: 200,
      body: {
        message: 'get_fair_price_products',
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
        message: 'get_fair_price_products error, must have query params'
      }.to_json
    }
  end

  response
end
