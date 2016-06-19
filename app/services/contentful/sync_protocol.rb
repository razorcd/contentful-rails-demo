class Contentful::SyncProtocol
  def initialize
    @url = Contentful::SyncUrl.new
  end

  def each_items_batch
    response = get_hash_response(@url.get)
    loop do
      response_items = response["items"].to_a

      serialized_items = response_items.map do |response_item|
        Contentful::ItemFactory.new(response_item).get_item
      end.compact
      yield serialized_items

      (update_next_sync_url(response["nextSyncUrl"]); break) unless response["nextPageUrl"]
      response = get_hash_response(response["nextPageUrl"].to_s)
    end
  end

private

  def get_hash_response url
    response = request url
    JSON.parse response
  end

  def request url
    RestClient.get(url).tap {|response| log_request(url, response) }
  end

  def next_sync_uri
    if @initial_sync
      build_initial_request_uri
    else
      build_next_sync_uri
    end
  end

  def update_next_sync_url url
    @url.set_next(url: url.to_s) unless url.to_s.empty?
  end

  def log_request request_url, response
    Rails.logger.info "\nRequesting HTTP GET URL: #{request_url}"
    Rails.logger.info("\nResponse:"); Rails.logger.info(response); Rails.logger.info("\n")
  end
end
