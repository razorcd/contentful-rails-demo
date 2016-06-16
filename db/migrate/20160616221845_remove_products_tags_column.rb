class RemoveProductsTagsColumn < ActiveRecord::Migration
  def up
    remove_column :products, :tags
  end

  def down
    raise("Migration irreversible")
  end
end
