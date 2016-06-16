class ProductsController < ApplicationController
  def index
    render json: Product.all,
        only: [:id, :name, :remote_id, :created_at, :updated_at, :slug, :description,
           :size_type_color, :price, :quantity, :sku, :website],
        methods: [:tag_values]
  end
end
