require "rails_helper"

RSpec.describe Contentful do
  context "#syncronize_products!" do
    it "should iterate over items and update DB records" do
      protocol_double = instance_double(Contentful::SyncProtocol)
      expect(Contentful::SyncProtocol).to receive(:new).and_return(protocol_double)
      expect(protocol_double).to receive(:each_items_batch).and_yield([{
        type: :entry,
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
      }).once

      tag_double = instance_double(Tag)
      expect(Tag).to receive(:find_or_create_by).with(value: /a|b/).exactly(2).times.and_return(tag_double)
      expect(product_double).to receive(:update).with({:tags=>[tag_double, tag_double]}).once

      Contentful.new.syncronize_products!
    end

    it "should iterate over items and destroy DB records" do
      protocol_double = instance_double(Contentful::SyncProtocol)
      expect(Contentful::SyncProtocol).to receive(:new).and_return(protocol_double)
      expect(protocol_double).to receive(:each_items_batch).and_yield([{
        type: :deleted_entry,
        id: "123",
      }])

      product_double = instance_double(Product)
      expect(Product).to receive(:find_by).with(remote_id: "123").and_return(product_double)
      expect(product_double).to receive(:destroy).once

      Contentful.new.syncronize_products!
    end

  end
end
