class ProductsController < ApplicationController
  def index
    render json: Product.order(:created_at).all,
        only: [:id, :name, :remote_id, :created_at, :updated_at, :slug, :description,
           :size_type_color, :price, :quantity, :sku, :website],
        methods: [:tag_values]
  end

  def sync_all
    Contentful.new.syncronize_products!

    render nothing: true, status: 200
  end

  def reset_and_sync_all
    ActiveRecord::Base.transaction do
      products= Product.delete_all
      products= Tag.delete_all
    end
    Contentful.new.syncronize_products!

    render nothing: true, status: 200
  end
end
