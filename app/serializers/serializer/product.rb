  class Serializer::Product
    def initialize product
      @product = product
    end

    def as_json options = {}
      {
        id: @product.id,
        name: @product.name,
        remote_id: @product.remote_id,
        slug: @product.slug,
        description: @product.description,
        size_type_color: @product.size_type_color,
        price: @product.price,
        quantity: @product.quantity,
        sku: @product.sku,
        website: @product.website,
        categories: categories,
        asset: asset,
        tags: tags,
      }
    end

    private

    def categories
      @product.categories.map do |category|
        Serializer::Category.new category
      end
    end

    def tags
      Serializer::Tags.new @product.tags
    end

    def asset
      asset = @product.asset
      return nil unless asset
      Serializer::Asset.new asset
    end
  end
