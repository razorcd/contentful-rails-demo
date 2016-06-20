require "rails_helper"

RSpec.describe Contentful::ItemFactory::AssetItem do
  let(:response_item_hash) do
    {
      "sys" => {"id" => "some_id_here"},
      "fields" => {
        "title" => {"en-US" => "title_here"},
        "description" => {"en-US" => "description_here"},
        "file" => {"en-US" => {"url" => "//www.example.com/image1.jpg"}},
      }
    }
  end

  context "#syncronize_db!" do
    it "should create or update a Asset record" do
      asset_double = instance_double(Asset)
      expect(Asset).to receive(:find_or_create_by).with(remote_id: "some_id_here").and_return(asset_double)

      expect(asset_double).to receive(:update!).with({
          title: "title_here",
          description: "description_here",
          remote_file_url: "#{ENV['DEFAULT_ASSET_URI_SCHEME']}://www.example.com/image1.jpg",
          file: "http://www.example.com/image1.jpg",
        })

      asset_item = Contentful::ItemFactory::AssetItem.new(response_item_hash)
      asset_item.syncronize_db!
    end
  end
end
