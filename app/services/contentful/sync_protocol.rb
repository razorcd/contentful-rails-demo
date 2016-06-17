class Contentful::SyncProtocol
  def initialize
    @url = Contentful::SyncUrl.new
  end

  def each_items_batch
    response = get_hash_response
    loop do
      items = response["items"]
      break if items.empty?

      serialized_items = items.map do |item|
        Contentful::SyncSerializer.item(item)
      end.compact
      yield serialized_items

      @url.set_next(url: response["nextSyncUrl"].to_s) if response["nextSyncUrl"]
      break unless response["nextPageUrl"]
      response = JSON.parse request(response["nextPageUrl"])
    end
  end

private

  def get_hash_response
    response = request @url.get
    hash_response = JSON.parse response
    hash_response
  end

  def request url
    RestClient.get url
  end

  def next_sync_uri
    if @initial_sync
      build_initial_request_uri
    else
      build_next_sync_uri
    end
  end
end
