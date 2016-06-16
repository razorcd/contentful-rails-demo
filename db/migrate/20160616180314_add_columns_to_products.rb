class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_column :products, :description, :string
    add_column :products, :size_type_color, :string
    add_column :products, :tags, :string
    add_column :products, :price, :integer
    add_column :products, :quantity, :integer
    add_column :products, :sku, :string
    add_column :products, :website, :string
  end
end
