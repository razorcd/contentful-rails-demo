class Contentful::ItemFactory::DeletedEntryItem
  def initialize response_item
    @serialized_item = {
      id: response_item["sys"]["id"],
    }
  end

  def syncronize_db!
    Product.find_by(remote_id: @serialized_item[:id]).destroy!
  end

end
