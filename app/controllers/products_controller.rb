class ProductsController < ApplicationController
  def index
    render json: Product.order(:created_at).all,
        only: [:id, :name, :remote_id, :created_at, :updated_at, :slug, :description,
           :size_type_color, :price, :quantity, :sku, :website],
        methods: [:tag_values, :category_titles]
  end

  def sync_all
    syncronize_products!

    render nothing: true, status: 200
  end

  def reset_and_sync_all
    clear_products_and_tags
    Contentful::SyncUrl.new.reset!
    syncronize_products!

    render nothing: true, status: 200
  end

private

  def clear_products_and_tags
    ActiveRecord::Base.transaction do
      products= Product.delete_all
      products= Tag.delete_all
      products= Category.delete_all
      products= Asset.delete_all
    end
  end

  def syncronize_products!
    Contentful.new.syncronize_products!
  end
end
