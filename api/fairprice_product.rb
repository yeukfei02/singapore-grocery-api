# frozen_string_literal: true

require 'faraday'

def fair_price_products_request(search_keyword, page = '0')
  products_result = []
  page_result = 0
  per_page_result = 20
  max_page_result = 0
  query_result = ''

  conn = request_base
  response = conn.get('') do |req|
    req.params['q'] = search_keyword

    req.params['page'] = page.to_s if !page.nil? && !page.empty? && page.to_s != '0'
  end

  if response.status == 200 && !response.body.nil? && !response.body.empty?
    response_body = JSON.parse(response.body)

    if response_body['data'] && response_body['data']['page'] && response_body['data']['page']['layouts']
      layouts = response_body['data']['page']['layouts']
      product_collection = layouts[layouts.length - 1]

      if !product_collection['value']['collection'].nil? && !product_collection['value']['collection'].empty? && !product_collection['value']['collection']['pagination'].nil? && !product_collection['value']['collection']['pagination'].empty?
        products_response = product_collection['value']['collection']['product']
        page_response = product_collection['value']['collection']['pagination']['page']
        per_page_response = product_collection['value']['collection']['pagination']['page_size']
        max_page_response = product_collection['value']['collection']['pagination']['total_pages']

        products_result = products_response
        page_result = page_response
        per_page_result = per_page_response
        max_page_result = max_page_response
        query_result = search_keyword
      end
    end
  end

  [products_result, page_result, per_page_result, max_page_result, query_result]
end

def request_base
  Faraday.new(
    url: 'https://website-api.omni.fairprice.com.sg/api/layout/search/v2',
    params: {
      "includeTagDetails": 'true',
      'orderType': 'DELIVERY'
    },
    headers: { 'Content-Type': 'application/json' }
  )
end
