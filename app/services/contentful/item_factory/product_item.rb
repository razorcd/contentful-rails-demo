class Contentful::ItemFactory::ProductItem
  def initialize response_item
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
      category_remote_ids: response_item.dig("fields", "categories", "en-US").map {|c| c["sys"]["id"]} || [],
    }
  end

  def syncronize_db!
    Product.transaction do
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
        categories: product_categories,
      }) #skips calling SQL query if data is the same
    end
  end

private

  def product
    @product ||= Product.find_or_create_by(remote_id: @serialized_item[:id])
  end

  def product_categories #TODO memoize it
    category_remote_ids = @serialized_item[:category_remote_ids]
    return [] if category_remote_ids.blank?
    category_remote_ids.map do |category_remote_id|
      Category.find_or_create_by(remote_id: category_remote_id)
    end
  end

  def update_and_load_tags tags #TODO memoize it
    return [] if tags.blank?
    tags.map do |tag|
      Tag.find_or_create_by(value: tag)
    end
  end
end
