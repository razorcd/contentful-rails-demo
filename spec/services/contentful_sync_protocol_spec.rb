require "rails_helper"

RSpec.describe ContentfulSyncProtocol do
  let(:sync_data) do
    VCR.use_cassette("sync_data") do
      ContentfulSyncProtocol.new.sync_data
    end
  end

  context "#sync_data" do
    it "should return JSON with an array of items" do
      json_data = JSON.parse(sync_data)
      expect(json_data.class).to eq Hash
      expect(json_data.keys).to include "items"
      expect(json_data["items"].class).to eq Array
    end
  end

end
