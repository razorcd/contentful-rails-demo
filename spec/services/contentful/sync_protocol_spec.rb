require "rails_helper"

RSpec.describe Contentful::SyncProtocol do
  let(:protocol) { Contentful::SyncProtocol.new }

  context "#each_items_batch" do
    it "should yield" do
      VCR.use_cassette("sync_request") do
        expect { |b| protocol.each_items_batch(&b) }.to yield_control
      end
    end

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
          expect(items[0].keys).to include :name
          expect(items[0].keys).to include :slug
          expect(items[0].keys).to include :description
          expect(items[0].keys).to include :size_type_color
          expect(items[0].keys).to include :tags
          expect(items[0].keys).to include :price
          expect(items[0].keys).to include :quantity
          expect(items[0].keys).to include :sku
          expect(items[0].keys).to include :website
          expect(items[0].keys.length).to eq 10
        end
      end
    end
  end

end
