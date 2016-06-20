class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  belongs_to :asset

  scope :tag_values, -> { tags.map(&:value) }
  scope :category_titles, -> { categories.map(&:title) }
  scope :asset_url, -> { asset && asset.file.url }
end
