require "rails_helper"

RSpec.describe ContentfulSyncProtocol do
  let(:protocol) { ContentfulSyncProtocol.new }

  context "#each_items_batch" do
    it "should return an array of items" do
      VCR.use_cassette("sync_request") do
        protocol.each_items_batch do |items|
          expect(items.length > 0).to be true
        end
      end
    end

    it "should return serialized items" do
      VCR.use_cassette("sync_request") do
        protocol.each_items_batch do |items|
          expect(items[0].keys).to include :id
          expect(items[0].keys).to include :product_name
          expect(items[0].keys.length).to eq 2
        end
      end
    end
  end

end
