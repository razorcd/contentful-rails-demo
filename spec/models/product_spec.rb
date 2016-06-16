require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should have fields" do
    all_columns = Product.columns.map(&:name)
    expect(all_columns).to match(
        ["id", "name", "remote_id", "created_at", "updated_at", "slug", "description",
         "size_type_color", "tags", "price", "quantity", "sku", "website"])
  end
end
