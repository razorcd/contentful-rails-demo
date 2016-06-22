class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token  #disables CSRF token

  def index
    render json: products.map {|product| ::Serializer::Product.new(product)}
  end

  def sync_all
    items_changed_count = contentful.syncronize_products!
    if items_changed_count < 0
      render json: {error_message: contentful.message}, status: 500
    else
      render json: {items_changed_count: items_changed_count}, status: 200
    end
  end

  def reset_and_sync_all
    ResourceCleaner.wipe_all
    contentful.reset_to_initial!
    contentful.syncronize_products!

    render nothing: true, status: 200
  end

private

  def products
    Product.order(:created_at).eager_load(:categories, :tags, :asset).all
  end

  def contentful
    @contentful ||= Contentful.new
  end
end
