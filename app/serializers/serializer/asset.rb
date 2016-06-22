  class Serializer::Asset
    def initialize asset
      @asset = asset
    end

    def as_json options = {}
      {
        id: @asset.id,
        remote_id: @asset.remote_id,
        title: @asset.title,
        description: @asset.description,
        file_url: @asset.file&.url
      }
    end
  end
