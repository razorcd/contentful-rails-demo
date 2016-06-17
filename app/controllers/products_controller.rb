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
end
