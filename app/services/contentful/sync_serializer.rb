module Contentful::Serializer
  def self.item item
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
end
