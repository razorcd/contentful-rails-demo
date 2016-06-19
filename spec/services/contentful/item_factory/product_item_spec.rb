require "rails_helper"

RSpec.describe Contentful::ItemFactory::ProductItem do
  let(:response_item_hash) do
    {
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
        "categories" => {
          "en-US" => [
            {"sys" => {"id" => "111"}},
            {"sys" => {"id" => "222"}},
          ]
        },
        "image" => {"en-US" => {"sys" => {"id" => "image_id_here"}}},
      }
    }
  end

  context "#syncronize_db!" do
    it "should create or update a Product record" do
      product_double = instance_double(Product)
      tag_double = instance_double(Tag)
      category_double1 = instance_double(Category)
      category_double2 = instance_double(Category)
      image_double = instance_double(Asset)

      expect(Product).to receive(:find_or_create_by).with(remote_id: "some_id_here").and_return(product_double)
      expect(Tag).to receive(:find_or_create_by).with(value: "tag1").and_return(tag_double)
      expect(Category).to receive(:find_or_create_by).with(remote_id: "111").and_return(category_double1)
      expect(Category).to receive(:find_or_create_by).with(remote_id: "222").and_return(category_double2)
      expect(Asset).to receive(:find_or_create_by).with(remote_id: "image_id_here").and_return(image_double)


      expect(product_double).to receive(:update!).with({
          name: "production_name_here",
          slug: "slug_here",
          description: "productDescription_here",
          size_type_color: "sizetypecolor_here",
          price: 10,
          quantity: 5,
          sku: "sku_here",
          website: "http://www.example.com",
          tags: [tag_double],
          categories: [category_double1, category_double2],
          asset: image_double,
        })

      product_item = Contentful::ItemFactory::ProductItem.new(response_item_hash)
      product_item.syncronize_db!
    end
  end
end
