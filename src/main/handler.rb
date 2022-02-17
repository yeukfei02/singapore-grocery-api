# frozen_string_literal: true

require 'json'

def main(event:, context:)
  {
    statusCode: 200,
    body: {
      message: 'singapore-grocery-api'
    }.to_json
  }
end
