require 'rest_client'
ACCESS_TOKEN = ENV["ACCESS_TOKEN"]
SPACE = ENV["SPACE"]
CONTENT_TYPE=ENV["CONTENT_TYPE"]

class ContentfulSyncProtocol
  def sync_data
    initial="true"
    type="Deletion"
    RestClient.get "https://cdn.contentful.com/spaces/#{SPACE}/sync?access_token=#{ACCESS_TOKEN}&initial=#{initial}&type=#{type}&content_type=#{CONTENT_TYPE}"
  end
end
