require "rails_helper"

RSpec.describe Contentful do
  context "#syncronize_products!" do
    it "should iterate over items and synchronize them" do
      protocol_double = instance_double(Contentful::SyncProtocol)
      item_double = instance_double(Contentful::ItemFactory::ProductItem)

      expect(Contentful::SyncProtocol).to receive(:new).and_return(protocol_double)
      expect(protocol_double).to receive(:each_items_batch).and_yield([item_double])
      expect(item_double).to receive(:syncronize_db!)

      Contentful.new.syncronize_products!
    end
  end
end
