class Description < ActiveRecord::Base
  has_one :user
  attr_accessible :address, :information, :name, :phone, :picture, :user
end
