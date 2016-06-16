require 'rest_client'

class ContentfulSyncProtocol
  ACCESS_TOKEN = ENV["ACCESS_TOKEN"]
  SPACE = ENV["SPACE"]
  CONTENT_TYPE = ENV["CONTENT_TYPE"]

  def initialize
    @items = []
  end

  def items
    response = JSON.parse request(uri: build_initial_request_uri)

    loop do
      response_items = response["items"]
      puts response_items.count
      break if response_items.empty?

      response_items.each do |item|
        @items << serialize(item)
        # yield serialize(item)
      end

      next_request_uri = build_next_request_uri from_uri: response["nextSyncUrl"]
      response = JSON.parse request(uri: next_request_uri)

      binding.pry
    end

    @items
  end

private

  def request uri:
    RestClient.get uri
  end

  def build_initial_request_uri
    initial = "initial=true"
    access_token = "access_token=#{ACCESS_TOKEN}"
    type = "type=Entry"
    content_type = "content_type=#{CONTENT_TYPE}"
    query = [initial, access_token, type, content_type].join("&")

    "https://cdn.contentful.com/spaces/#{SPACE}/sync?#{query}"
  end

  def build_next_request_uri from_uri:
    access_token = "access_token=#{ACCESS_TOKEN}"
    "#{from_uri}&#{access_token}"
  end

  def serialize item
    {
      id: item["sys"]["id"],
      product_name: item["fields"]["productName"]["en-US"],
    }
  end
end

