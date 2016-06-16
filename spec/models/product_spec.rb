require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should have fields" do
    all_columns = Product.columns.map(&:name)
    expect(all_columns).to match(
        ["id", "name", "remote_id", "created_at", "updated_at", "slug", "description",
         "size_type_color", "price", "quantity", "sku", "website"])
  end

  it "should have associations" do
    associations = Product.reflect_on_all_associations
    expect(associations.map(&:name)).to match [:tags]
    expect(associations.map(&:class)).to eq [ActiveRecord::Reflection::HasAndBelongsToManyReflection]
  end
end
