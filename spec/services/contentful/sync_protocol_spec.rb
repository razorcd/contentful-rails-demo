require "rails_helper"

RSpec.describe Contentful::SyncProtocol do
  let(:protocol) { Contentful::SyncProtocol.new }
  before(:each) do
    Contentful::SyncUrl.new.reset!

    item_factory = instance_double(Contentful::ItemFactory)
    allow(Contentful::ItemFactory).to receive(:new).at_least(:once).and_return(item_factory)
    allow(item_factory).to receive(:get_item).at_least(:once).and_return [double]
  end

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

  end
end
