module Contentful::SyncSerializer
  def self.item item
    type = item.dig("sys", "type")
    content_type_id = item.dig("sys", "contentType", "sys", "id")
    if type == "Entry" && content_type_id == ENV["PRODUCT_CONTENT_TYPE"]
      return self.product_entry item
    elsif type == "DeletedEntry"
      return self.deletion item
    else
      return nil
    end
  end

  def self.product_entry item
    {
      type: :entry,
      id: item["sys"]["id"],
      name: item.dig("fields", "productName", "en-US"),
      slug: item.dig("fields", "slug", "en-US"),
      description: item.dig("fields", "productDescription", "en-US") || "",
      size_type_color: item.dig("fields", "sizetypecolor", "en-US") || "",
      tags: item.dig("fields", "tags", "en-US") || [],
      price: item.dig("fields", "price", "en-US"),
      quantity: item.dig("fields", "quantity", "en-US") || 0,
      sku: item.dig("fields", "sku", "en-US") || "",
      website: item.dig("fields", "website", "en-US") || "",
    }
  end

  def self.deletion item
    {
      type: :deleted_entry,
      id: item["sys"]["id"],
    }
  end
end
