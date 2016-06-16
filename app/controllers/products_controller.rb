class ProductsController < ApplicationController
  def index
    render json: Product.all, only: [:id, :name]
  end
end
