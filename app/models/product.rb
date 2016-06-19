class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :category

  def tag_values  #TODO: change to scope
    tags.map(&:value)
  end
end
