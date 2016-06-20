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
      category_remote_ids: response_item.dig("fields", "categories", "en-US")&.map {|c| c["sys"]["id"]} || [],
      image_remote_id: response_item.dig("fields", "image", "en-US", "sys", "id"),
    }
  end

  def syncronize_db!
    Product.transaction do
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
        asset: product_asset,
      }) #skips calling SQL query if data is the same
    end
  end

private

  def product
    @product ||= Product.find_or_create_by(remote_id: @serialized_item[:id])
  end

  def product_categories
    return [] if @serialized_item[:category_remote_ids].blank?
    @serialized_item[:category_remote_ids].map do |category_remote_id|
      Category.find_or_create_by(remote_id: category_remote_id)
    end
  end

  def product_asset
    return nil if @serialized_item[:image_remote_id].blank?
    Asset.find_or_create_by(remote_id: @serialized_item[:image_remote_id])
  end

  def tags
    return [] if @serialized_item[:tags].blank?
    @serialized_item[:tags].map do |tag|
      Tag.find_or_create_by(value: tag)
    end
  end
end


__END__

product example:

{
  "sys": {
    "space": {
      "sys": {
        "type": "Link",
        "linkType": "Space",
        "id": "irjb6cmr6p6c"
      }
    },
    "id": "4BqrajvA8E6qwgkieoqmqO",
    "type": "Entry",
    "createdAt": "2016-06-09T18:40:28.772Z",
    "updatedAt": "2016-06-09T18:40:28.772Z",
    "revision": 1,
    "contentType": {
      "sys": {
        "type": "Link",
        "linkType": "ContentType",
        "id": "2PqfXUJwE8qSYKuM0U6w8M"
      }
    }
  },
  "fields": {
    "productName": {
      "en-US": "SoSo Wall Clock"
    },
    "slug": {
      "en-US": "soso-wall-clock"
    },
    "productDescription": {
      "en-US": "The newly released SoSo Clock from Lemnos marries simple, clean design and bold, striking features. Its saturated marigold face is a lively pop of color to white or grey walls, but would also pair nicely with navy and maroon. Where most clocks feature numbers at the border of the clock, the SoSo brings them in tight to the middle, leaving a wide space between the numbers and the slight frame. The hour hand provides a nice interruption to the black and yellow of the clock - it is featured in a brilliant white. Despite its bold color and contrast, the SoSo maintains a clean, pure aesthetic that is suitable to a variety of contemporary interiors."
    },
    "sizetypecolor": {
      "en-US": "10\" x 2.2\""
    },
    "image": {
      "en-US": [
        {
          "sys": {
            "type": "Link",
            "linkType": "Asset",
            "id": "KTRF62Q4gg60q6WCsWKw8"
          }
        }
      ]
    },
    "tags": {
      "en-US": [
        "home décor",
        "clocks",
        "interior design",
        "yellow",
        "gifts"
      ]
    },
    "categories": {
      "en-US": [
        {
          "sys": {
            "type": "Link",
            "linkType": "Entry",
            "id": "7LAnCobuuWYSqks6wAwY2a"
          }
        }
      ]
    },
    "price": {
      "en-US": 120
    },
    "brand": {
      "en-US": {
        "sys": {
          "type": "Link",
          "linkType": "Entry",
          "id": "4LgMotpNF6W20YKmuemW0a"
        }
      }
    },
    "quantity": {
      "en-US": 3
    },
    "sku": {
      "en-US": "B00MG4ULK2"
    },
    "website": {
      "en-US": "http://store.dwell.com/soso-wall-clock.html"
    }
  }
},
