class Contentful::ItemFactory::CategoryItem
  def initialize response_item
    #TODO: add params.permit ???
    @serialized_item = {
      id: response_item["sys"]["id"],
      title: response_item.dig("fields", "title", "en-US"),
      description: response_item.dig("fields", "categoryDescription", "en-US"),
    }
  end

  def syncronize_db!
    Category.transaction do
      product = Category.find_or_create_by(remote_id: @serialized_item[:id])

      product.update!({
        title: @serialized_item[:title],
        description: @serialized_item[:description],
      }) #skips calling SQL query if data is the same
    end
  end
end


__END__

response_item example:

{
   "sys" => {
          "space" => {
        "sys" => {
                "type" => "Link",
            "linkType" => "Space",
                  "id" => "irjb6cmr6p6c"
        }
    },
             "id" => "7LAnCobuuWYSqks6wAwY2a",
           "type" => "Entry",
      "createdAt" => "2016-06-09T18:40:29.029Z",
      "updatedAt" => "2016-06-09T18:40:29.029Z",
       "revision" => 1,
    "contentType" => {
        "sys" => {
                "type" => "Link",
            "linkType" => "ContentType",
                  "id" => "6XwpTaSiiI2Ak2Ww0oi6qa"
        }
    }
  },
  "fields" => {
                  "title" => {
        "en-US" => "Home & Kitchen"
    },
                 "icon" => {
        "en-US" => {
            "sys" => {
                    "type" => "Link",
                "linkType" => "Asset",
                      "id" => "6m5AJ9vMPKc8OUoQeoCS4o"
            }
        }
    },
    "categoryDescription" => {
        "en-US" => "Shop for furniture, bedding, bath, vacuums, kitchen products, and more"
    }
  }
}
