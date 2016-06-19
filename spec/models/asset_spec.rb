require 'rails_helper'

RSpec.describe Asset, type: :model do
  it "should have fields" do
    all_columns = Asset.columns.map(&:name)
    expect(all_columns).to match_array([
      "created_at", "description", "file_content_type", "file_file_name", "file_file_size",
      "file_updated_at", "remote_file_url", "id", "remote_id", "title", "updated_at"
    ])
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
