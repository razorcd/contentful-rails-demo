class ProductsController < ApplicationController
  def index
    render json: Product.order(:created_at).all,
        only: [:id, :name, :remote_id, :created_at, :updated_at, :slug, :description,
           :size_type_color, :price, :quantity, :sku, :website],
        methods: [:tag_values, :category_titles, :asset_url]
  end

  def sync_all
    contentful.syncronize_products!

    render nothing: true, status: 200
  end

  def reset_and_sync_all
    ResourceCleaner.wipe_all
    contentful.reset_to_initial!
    contentful.syncronize_products!

    render nothing: true, status: 200
  end

private

  def contentful
    @contentful ||= Contentful.new
  end
end
