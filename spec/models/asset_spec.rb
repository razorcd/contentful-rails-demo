require 'rails_helper'

RSpec.describe Asset, type: :model do
  it "should have fields" do
    all_columns = Asset.columns.map(&:name)
    expect(all_columns).to match_array(
        ["id", "remote_id", "title", "description", "file_url", "created_at", "updated_at"])
  end

  it "should have associations" do
    associations = Asset.reflect_on_all_associations.map {|a| {name: a.name, class: a.class}}

    expect(associations).to match_array [
        {
          name: :product,
          class: ActiveRecord::Reflection::HasOneReflection,
        },
      ]
  end
end
