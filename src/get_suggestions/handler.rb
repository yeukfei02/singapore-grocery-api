# frozen_string_literal: true

require 'json'
require_relative '../../api/suggestions'

def get_suggestions(event:, context:)
  response = {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Credentials": true
    },
    body: {
      message: 'get_suggestions'
    }.to_json
  }

  if !event['queryStringParameters'].nil? && !event['queryStringParameters'].empty?
    search_keyword = event['queryStringParameters']['search_keyword']

    suggestions = suggestions_request(search_keyword)

    response = {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true
      },
      body: {
        message: 'get_suggestions',
        suggestions: suggestions
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
        message: 'get_suggestions error, must have query params'
      }.to_json
    }
  end

  response
end
