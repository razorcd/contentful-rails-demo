require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "should have fields" do
    all_columns = Tag.columns.map(&:name)
    expect(all_columns).to match(["id", "value", "created_at", "updated_at"])
  end

  it "should have associations" do
    associations = Tag.reflect_on_all_associations
    expect(associations.map(&:name)).to match [:product]
    expect(associations.map(&:class)).to eq [ActiveRecord::Reflection::HasAndBelongsToManyReflection]
  end
end
