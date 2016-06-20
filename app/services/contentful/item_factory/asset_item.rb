class Contentful::ItemFactory::AssetItem
  def initialize response_item
    @serialized_item = {
      id: response_item["sys"]["id"],
      title: response_item.dig("fields", "title", "en-US"),
      description: response_item.dig("fields", "description", "en-US") || "",
      file_url: response_item.dig("fields", "file", "en-US", "url") || "",
    }
  end

  def syncronize_db!
    Asset.transaction do
      asset.update!({
        title: @serialized_item[:title],
        description: @serialized_item[:description],
        remote_file_url: @serialized_item[:file_url],
        file: asset_url,
      }) #skips calling SQL query if data is the same
    end
  end

private

  def asset
    @asset ||= Asset.find_or_create_by(remote_id: @serialized_item[:id])
  end

  def asset_url
    url = URI.parse(@serialized_item[:file_url])
    url.scheme ||= ENV['DEFAULT_ASSET_URI_SCHEME']
    url.to_s
  end
end


__END__

asset example:
{
  "sys": {
    "space": {
      "sys": {
        "type": "Link",
        "linkType": "Space",
        "id": "irjb6cmr6p6c"
      }
    },
    "id": "KTRF62Q4gg60q6WCsWKw8",
    "type": "Asset",
    "createdAt": "2016-06-09T18:40:22.181Z",
    "updatedAt": "2016-06-09T18:40:22.181Z",
    "revision": 1
  },
  "fields": {
    "title": {
      "en-US": "SoSo Wall Clock"
    },
    "description": {
      "en-US": "by Lemnos"
    },
    "file": {
      "en-US": {
        "url": "//images.contentful.com/irjb6cmr6p6c/KTRF62Q4gg60q6WCsWKw8/676859cb2a0a9eaae1cf9b0e2575e828/soso.clock.jpg",
        "details": {
          "size": 66927,
          "image": {
            "width": 1000,
            "height": 1000
          }
        },
        "fileName": "soso.clock.jpg",
        "contentType": "image/jpeg"
      }
    }
  }
},
