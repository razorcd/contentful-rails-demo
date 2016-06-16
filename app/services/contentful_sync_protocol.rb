require 'rest_client'
ACCESS_TOKEN = ""
SPACE = ""

class ContentfulSyncProtocol
  def sync_data
    initial="true"
    type="Deletion"
    RestClient.get "https://cdn.contentful.com/spaces/#{SPACE}/sync?access_token=#{ACCESS_TOKEN}&initial=#{initial}&type=#{type}"
  end
end
