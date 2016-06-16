class ContentfulSyncProtocol
  ACCESS_TOKEN = ENV["ACCESS_TOKEN"]
  SPACE = ENV["SPACE"]
  CONTENT_TYPE = ENV["CONTENT_TYPE"]

  def each_items_batch
    response = JSON.parse request(uri: build_initial_request_uri)

    loop do
      response_items = response["items"]
      break if response_items.empty?

      serialized_items = response_items.map {|item| serialize(item) }
      yield serialized_items

      next_request_uri = build_next_request_uri from_uri: response["nextSyncUrl"]
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
      name: item["fields"]["productName"]["en-US"],
    }
  end
end

