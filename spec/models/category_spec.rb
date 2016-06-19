require 'rails_helper'

RSpec.describe Category, type: :model do
  it "should have fields" do
    all_columns = Category.columns.map(&:name)
    expect(all_columns).to match_array(["id", "title", "remote_id", "description", "created_at", "updated_at"])
  end

  it "should have associations" do
    associations = Category.reflect_on_all_associations.map {|a| {name: a.name, class: a.class}}

    expect(associations).to match_array [
        {
          name: :products,
          class: ActiveRecord::Reflection::HasAndBelongsToManyReflection,
        },
      ]
  end
end
