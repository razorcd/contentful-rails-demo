require "rails_helper"

RSpec.describe Contentful::ItemFactory do
  context "#get_item" do
    it "should return a ProductItem instance for a Product response item" do
      product_item = instance_double(Contentful::ItemFactory::ProductItem)
      expect(Contentful::ItemFactory::ProductItem).to receive(:new).and_return(product_item)
      expect(Contentful::ItemFactory::CategoryItem).not_to receive(:new)
      expect(Contentful::ItemFactory::AssetItem).not_to receive(:new)
      expect(Contentful::ItemFactory::DeletedEntryItem).not_to receive(:new)

      item_factory = Contentful::ItemFactory.new({
        "sys" => {
          "contentType" => {"sys" => {"id" => ENV["PRODUCT_CONTENT_TYPE"]}},
          "type" => "Entry",
        },
      })

      expect(item_factory.get_item).to eq product_item
    end

    it "should return a CategoryItem instance for a Category response item" do
      category_item = instance_double(Contentful::ItemFactory::CategoryItem)
      expect(Contentful::ItemFactory::ProductItem).not_to receive(:new)
      expect(Contentful::ItemFactory::CategoryItem).to receive(:new).and_return(category_item)
      expect(Contentful::ItemFactory::AssetItem).not_to receive(:new)
      expect(Contentful::ItemFactory::DeletedEntryItem).not_to receive(:new)

      item_factory = Contentful::ItemFactory.new({
        "sys" => {
          "contentType" => {"sys" => {"id" => ENV["CATEGORY_CONTENT_TYPE"]}},
          "type" => "Entry",
        },
      })

      expect(item_factory.get_item).to eq category_item
    end

    it "should return a AssetItem instance for an Asset response item" do
      asset_item = instance_double(Contentful::ItemFactory::AssetItem)
      expect(Contentful::ItemFactory::ProductItem).not_to receive(:new)
      expect(Contentful::ItemFactory::CategoryItem).not_to receive(:new)
      expect(Contentful::ItemFactory::AssetItem).to receive(:new).and_return(asset_item)
      expect(Contentful::ItemFactory::DeletedEntryItem).not_to receive(:new)

      item_factory = Contentful::ItemFactory.new({
        "sys" => {
          "type" => "Asset",
        },
      })

      expect(item_factory.get_item).to eq asset_item
    end

    it "should return a DeletedEntryItem instance for a Deleted Entry response item" do
      delete_item = instance_double(Contentful::ItemFactory::DeletedEntryItem)
      expect(Contentful::ItemFactory::ProductItem).not_to receive(:new)
      expect(Contentful::ItemFactory::CategoryItem).not_to receive(:new)
      expect(Contentful::ItemFactory::AssetItem).not_to receive(:new)
      expect(Contentful::ItemFactory::DeletedEntryItem).to receive(:new).and_return(delete_item)

      item_factory = Contentful::ItemFactory.new({
        "sys" => {
          "type" => "DeletedEntry",
        },
      })

      expect(item_factory.get_item).to eq delete_item
    end

    it "should return nil for unknown response items" do
      expect(Contentful::ItemFactory::ProductItem).not_to receive(:new)
      expect(Contentful::ItemFactory::DeletedEntryItem).not_to receive(:new)

      item_factory = Contentful::ItemFactory.new({
        "sys" => {
          "contentType" => {"sys" => {"id" => "unknown"}},
          "type" => "unknown",
        },
      })

      expect(item_factory.get_item).to eq nil
    end
  end
end
