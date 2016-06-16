class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def tag_values
    tags.map(&:value)
  end
end
