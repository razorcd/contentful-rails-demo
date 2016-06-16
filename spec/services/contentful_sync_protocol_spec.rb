require "rails_helper"

RSpec.describe ContentfulSyncProtocol do
  let(:items) do
    VCR.use_cassette("sync_request") do
      ContentfulSyncProtocol.new.items
    end
  end

  context "#items" do
    it "should return an array of items" do
      expect(items.length > 0).to be true
    end

    it "should return serialized items" do
      expect(items[0].keys).to include :id
      expect(items[0].keys).to include :product_name
      expect(items[0].keys.length).to eq 2
    end
  end

end
