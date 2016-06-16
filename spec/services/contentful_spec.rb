require "rails_helper"

RSpec.describe Contentful do
  context "#syncronize_products!" do
    it "should iterate over items and update the DB" do
      protocol_double = instance_double(ContentfulSyncProtocol)
      expect(ContentfulSyncProtocol).to receive(:new).and_return(protocol_double)
      expect(protocol_double).to receive(:each_items_batch).and_yield([{id: "123", name: "name123"}])

      product_double = instance_double(Product)
      expect(Product).to receive(:first_or_create).with(remote_id: "123").and_return(product_double)
      expect(product_double).to receive(:update).with(name: "name123")

      Contentful.new.syncronize_products!
    end
  end
end
