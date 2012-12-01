class Item < ActiveRecord::Base
  attr_accessible :name, :thumbnail, :price, :description
end
