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

    it "should follow 'nextPageUrl' url from response" do
      allow_any_instance_of(Contentful::SyncUrl::Sigleton).to receive(:get).and_return("http://www.example1.com")
      allow_any_instance_of(Contentful::SyncUrl::Sigleton).to receive(:set_next).with("http://www.example1.com")
      expect(RestClient).to receive(:get).with("http://www.example1.com").and_return("{\"nextPageUrl\":\"http://www.example2.com\"}")
      expect(RestClient).to receive(:get).with("http://www.example2.com").and_return("{\"nextPageUrl\":\"http://www.example3.com\"}")
      expect(RestClient).to receive(:get).with("http://www.example3.com").and_return("{}")

      protocol.each_items_batch {|items| items }
    end
  end
end
