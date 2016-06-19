class Contentful::ItemFactory
  def initialize response_item
    @response_item = response_item
  end

  def get_item
    content_type_id = @response_item.dig("sys", "contentType", "sys", "id")
    type = @response_item.dig("sys", "type")

    if content_type_id == ENV["PRODUCT_CONTENT_TYPE"]
      return Contentful::ItemFactory::ProductItem.new @response_item
    elsif content_type_id == ENV["CATEGORY_CONTENT_TYPE"]
      return Contentful::ItemFactory::CategoryItem.new @response_item
    elsif type == "DeletedEntry"
      return Contentful::ItemFactory::DeletedEntryItem.new @response_item
    else
      puts "Ignoring unknown item: content_type_id: '#{content_type_id}', type: '#{type}'."
      return nil
    end
  end

  # def self.category_entry item
  #   {
  #     model_class: Category,
  #     deleted: false,
  #     id: item["sys"]["id"],
  #   }
  # end
end
