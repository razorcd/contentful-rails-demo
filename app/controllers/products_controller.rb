class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token  #disables CSRF token

  def index
    render json: products.map {|product| ::Serializer::Product.new(product)}
  end

  def sync_all
    contentful.syncronize_products!
    render json: {}, status: 200
  end

  def reset_and_sync_all
    ResourceCleaner.wipe_all
    contentful.reset_to_initial_url!
    contentful.syncronize_products!

    render json: {}, status: 200
  end

private

  def products
    Product.order(:created_at).eager_load(:categories, :tags, :asset).all
  end

  def contentful
    @contentful ||= Contentful.new
  end
end
