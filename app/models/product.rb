class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories

  def tag_values  #TODO: change to scope
    tags.map(&:value)
  end

  def category_titles  #TODO: change to scope
    categories.map(&:title)
  end
end
