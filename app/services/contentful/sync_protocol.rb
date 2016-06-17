require_relative 'sync_serializer'

class Contentful::SyncProtocol
  ACCESS_TOKEN = ENV["ACCESS_TOKEN"]
  SPACE = ENV["SPACE"]

  def each_items_batch
    response = JSON.parse request(uri: build_initial_request_uri)

    loop do
      response_items = response["items"]
      break if response_items.empty?

      serialized_items = response_items.map do |item|
        Contentful::Serializer.item(item)
      end.compact
      yield serialized_items

      break unless response["nextPageUrl"]
      next_request_uri = build_next_page_request_uri from_uri: response["nextPageUrl"]
      response = JSON.parse request(uri: next_request_uri)
    end
  end

private

  def request uri:
    RestClient.get uri
  end

  def build_initial_request_uri
    initial = "initial=true"
    access_token = "access_token=#{ACCESS_TOKEN}"
    query = [initial, access_token].compact.join("&")

    "https://cdn.contentful.com/spaces/#{SPACE}/sync?#{query}"
  end

  def build_next_page_request_uri from_uri:
    access_token = "access_token=#{ACCESS_TOKEN}"
    "#{from_uri}&#{access_token}"
  end
end

