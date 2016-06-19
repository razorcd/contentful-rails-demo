require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should have fields" do
    all_columns = Product.columns.map(&:name)
    expect(all_columns).to match_array(
        ["id", "name", "remote_id", "created_at", "updated_at", "slug", "description",
         "size_type_color", "price", "quantity", "sku", "website", "asset_id"])
  end

  it "should have associations" do
    associations = Product.reflect_on_all_associations.map {|a| {name: a.name, class: a.class}}

    expect(associations).to match_array [
        {
          name: :tags,
          class: ActiveRecord::Reflection::HasAndBelongsToManyReflection,
        },
        {
          name: :categories,
          class: ActiveRecord::Reflection::HasAndBelongsToManyReflection,
        },
        {
          :name => :asset,
          :class => ActiveRecord::Reflection::BelongsToReflection,
        },
      ]
  end
end
