module Contentful::Serializer
  def self.item item
    if item["sys"]["type"] == "Entry" && item["sys"]["contentType"]["sys"]["id"] == ENV["PRODUCT_CONTENT_TYPE"]
      return self.product_entry item
    elsif item["sys"]["type"] == "Deletion"
      return self.deletion item
    else
      return nil
    end
  end

  def self.product_entry item
    {
      id: item["sys"]["id"],
      name: item["fields"]["productName"]["en-US"],
      slug: item["fields"]["slug"]["en-US"],
      description: item["fields"]["productDescription"]["en-US"],
      size_type_color: item["fields"]["sizetypecolor"]["en-US"],
      tags: item["fields"]["tags"]["en-US"],
      price: item["fields"]["price"]["en-US"],
      quantity: item["fields"]["quantity"]["en-US"],
      sku: item["fields"]["sku"]["en-US"],
      website: item["fields"]["website"]["en-US"],
    }
  end

  def self.deletion item
    {}
  end
end
