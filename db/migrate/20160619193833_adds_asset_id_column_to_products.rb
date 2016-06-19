class AddsAssetIdColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :asset_id, :integer
  end
end
