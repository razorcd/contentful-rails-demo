require "rails_helper"

RSpec.describe Contentful::ItemFactory::DeletedEntryItem do
  context "#syncronize_db!" do
    it "should destroy a Product record" do
      product_double = instance_double(Product)
      expect(Product).to receive(:find_by).with(remote_id: "some_id_here").and_return(product_double)
      expect(product_double).to receive(:destroy)

      deleted_entry_item = Contentful::ItemFactory::DeletedEntryItem.new({
            "sys" => {"id" => "some_id_here"},
          })
      deleted_entry_item.syncronize_db!
    end

    it "should destroy a Category record" do
      category_double = instance_double(Category)
      expect(Product).to receive(:find_by).with(remote_id: "some_id_here").and_return(nil)
      expect(Category).to receive(:find_by).with(remote_id: "some_id_here").and_return(category_double)
      expect(category_double).to receive(:destroy)

      deleted_entry_item = Contentful::ItemFactory::DeletedEntryItem.new({
            "sys" => {"id" => "some_id_here"},
          })
      deleted_entry_item.syncronize_db!
    end
  end
end
