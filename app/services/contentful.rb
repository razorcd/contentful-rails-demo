class Contentful
  def syncronize_products!
    ContentfulSyncProtocol.new.each_items_batch do |items|
      items.each {|item| update item}
    end
  end

private

  def update item
    Product.transaction do
      product = Product.find_or_create_by(remote_id: item[:id])
      product.update({
        name: item[:name],
        slug: item[:slug],
        description: item[:description],
        size_type_color: item[:size_type_color],
        price: item[:price],
        quantity: item[:quantity],
        sku: item[:sku],
        website: item[:website],
      }) #skips calling SQL query if data is the same
      product.tags = persisted_tags(item[:tags]) if item[:tags]
    end
  end

  def persisted_tags tags
    tags.map do |tag|
      Tag.find_or_create_by(value: tag)
    end
  end
end




