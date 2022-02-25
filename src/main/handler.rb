# frozen_string_literal: true

require 'json'

def main(event:, context:)
  {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Credentials": true
    },
    body: {
      message: 'singapore-grocery-api'
    }.to_json
  }
end
