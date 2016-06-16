require "rails_helper"

RSpec.describe Contentful do
  context "#syncronize_products!" do
    it "should iterate over items and update the DB" do
      protocol_double = instance_double(ContentfulSyncProtocol)
      expect(ContentfulSyncProtocol).to receive(:new).and_return(protocol_double)
      expect(protocol_double).to receive(:each_items_batch).and_yield([{
        id: "123",
        name: "name123",
        slug: "slug",
        tags: ["a", "b"],
        description: "lorem ipsum",
        size_type_color: "size",
        price: 1,
        quantity: 2,
        sku: "sku",
        website: "www",
      }])

      product_double = instance_double(Product)
      expect(Product).to receive(:find_or_create_by).with(remote_id: "123").and_return(product_double)
      expect(product_double).to receive(:update).with({
        name: "name123",
        slug: "slug",
        description: "lorem ipsum",
        size_type_color: "size",
        price: 1,
        quantity: 2,
        sku: "sku",
        website: "www",
      })
      expect(product_double).to receive(:tags=)
      expect(Tag).to receive(:find_or_create_by).with(value: /a|b/).exactly(2).times

      Contentful.new.syncronize_products!
    end
  end
end
