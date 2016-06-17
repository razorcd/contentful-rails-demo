class Contentful
  def syncronize_products!
    Contentful::SyncProtocol.new.each_items_batch do |items|
      items.each {|item| update_product item}
    end
  end

private

  def update_product item
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

      tags= update_and_load_tags(item[:tags])
      product.update(tags: tags)
    end
  end

  def update_and_load_tags tags
    return [] if tags.blank?
    tags.map do |tag|
      Tag.find_or_create_by(value: tag) #skips calling SQL query if data is the same
    end
  end
end




