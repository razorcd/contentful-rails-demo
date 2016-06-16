require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "should have fields" do
    all_columns = Product.columns.map(&:name)
    expect(all_columns).to match(["id", "value", "created_at", "updated_at"])
  end
end
