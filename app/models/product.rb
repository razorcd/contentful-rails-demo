class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  belongs_to :asset

  def tag_values
    tags.map(&:value)
  end

  def category_titles
    categories.map(&:title)
  end

  def asset_url
    asset && asset.file.url
  end
end
