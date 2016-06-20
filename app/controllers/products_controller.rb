class ProductsController < ApplicationController
  def index
    render json: Product.order(:created_at).eager_load(:categories, :tags, :asset).all,
        only: [
          :id, :name, :remote_id, :slug, :description, :size_type_color, :price, :quantity, :sku, :website
        ],
        include: {
          categories: {only: [:id, :remote_id, :title, :description]},
          tags: {only: :value},
          asset: {only: [:id, :remote_id, :title, :description, :remote_file_url]},
        }
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
