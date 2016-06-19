require "rails_helper"

RSpec.describe Contentful::ItemFactory::ProductItem do
  context "#syncronize_db!" do
    it "should create or update a Product record" do
      product_doule = instance_double(Product)
      tag_double = instance_double(Tag)
      expect(Product).to receive(:find_or_create_by).with(remote_id: "some_id_here").and_return(product_doule)
      expect(Tag).to receive(:find_or_create_by).with(value: "tag1").and_return(tag_double)
      expect(product_doule).to receive(:update!).with({
          name: "production_name_here",
          slug: "slug_here",
          description: "productDescription_here",
          size_type_color: "sizetypecolor_here",
          price: 10,
          quantity: 5,
          sku: "sku_here",
          website: "http://www.example.com",
          tags: [tag_double],
        })

      product_item = Contentful::ItemFactory::ProductItem.new({
            "sys" => {"id" => "some_id_here"},
            "fields" => {
              "productName" => {"en-US" => "production_name_here"},
              "slug" => {"en-US" => "slug_here"},
              "productDescription" => {"en-US" => "productDescription_here"},
              "sizetypecolor" => {"en-US" => "sizetypecolor_here"},
              "tags" => {"en-US" => ["tag1"]},
              "price" => {"en-US" => 10},
              "quantity" => {"en-US" => 5},
              "sku" => {"en-US" => "sku_here"},
              "website" => {"en-US" => "http://www.example.com"},
            }
          })
      product_item.syncronize_db!
    end
  end
end


