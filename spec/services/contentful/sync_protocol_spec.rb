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
        expect(Contentful::SyncSerializer).to receive(:item).and_return({}).at_least(1)
        protocol.each_items_batch {|items| items }
      end
    end
  end

end
