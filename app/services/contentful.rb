class Contentful
  def syncronize_products!
    ContentfulSyncProtocol.new.each_items_batch do |items|
      items.each {|item| update item}
    end
  end

private

  def update item
    product = Product.find_or_create_by(remote_id: item[:id])
    product.update({
      name: item[:name],
      slug: item[:slug],
      description: item[:description],
      size_type_color: item[:size_type_color],
      tags: item[:tags],
      price: item[:price],
      quantity: item[:quantity],
      sku: item[:sku],
      website: item[:website],
    }) #skips query if data is the same
  end
end




