class Contentful::ItemFactory::ProductItem
  def initialize response_item
    #TODO: add params.permit ???
    @serialized_item = {
      id: response_item["sys"]["id"],
      name: response_item.dig("fields", "productName", "en-US"),
      slug: response_item.dig("fields", "slug", "en-US"),
      description: response_item.dig("fields", "productDescription", "en-US") || "",
      size_type_color: response_item.dig("fields", "sizetypecolor", "en-US") || "",
      tags: response_item.dig("fields", "tags", "en-US") || [],
      price: response_item.dig("fields", "price", "en-US"),
      quantity: response_item.dig("fields", "quantity", "en-US") || 0,
      sku: response_item.dig("fields", "sku", "en-US") || "",
      website: response_item.dig("fields", "website", "en-US") || "",
    }
  end

  def syncronize_db!
    Product.transaction do
      product = Product.find_or_create_by(remote_id: @serialized_item[:id])
      tags= update_and_load_tags(@serialized_item[:tags])

      product.update!({
        name: @serialized_item[:name],
        slug: @serialized_item[:slug],
        description: @serialized_item[:description],
        size_type_color: @serialized_item[:size_type_color],
        price: @serialized_item[:price],
        quantity: @serialized_item[:quantity],
        sku: @serialized_item[:sku],
        website: @serialized_item[:website],
        tags: tags,
      }) #skips calling SQL query if data is the same
    end
  end

private

  def update_and_load_tags tags
    return [] if tags.blank?
    tags.map do |tag|
      Tag.find_or_create_by(value: tag) #skips calling SQL query if data is the same
    end
  end
end
