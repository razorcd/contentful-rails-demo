class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  belongs_to :asset
end
