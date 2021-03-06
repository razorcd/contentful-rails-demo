require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "should have fields" do
    all_columns = Tag.columns.map(&:name)
    expect(all_columns).to match_array(["id", "value", "created_at", "updated_at"])
  end

  it "should have associations" do
    associations = Tag.reflect_on_all_associations.map {|a| {name: a.name, class: a.class}}

    expect(associations).to match_array [
        {
          name: :product,
          class: ActiveRecord::Reflection::HasAndBelongsToManyReflection,
        },
      ]
  end
end
