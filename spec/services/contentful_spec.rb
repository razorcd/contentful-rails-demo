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

  context "#reset_to_initial_url!" do
    it "should reset sync url" do
      expect(Contentful::SyncUrl).to receive_message_chain(:new, :reset!)

      Contentful.new.reset_to_initial_url!
    end
  end
end
