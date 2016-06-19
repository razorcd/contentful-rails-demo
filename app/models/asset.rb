class Asset < ActiveRecord::Base
  has_one :product
end
