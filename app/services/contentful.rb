class Contentful
  def syncronize_products!
    Contentful::SyncProtocol.new.each_items_batch do |items|
      items.map(&:syncronize_db!)
    end
  end

  def reset_to_initial_url!
    Contentful::SyncUrl.new.reset!
  end
end




