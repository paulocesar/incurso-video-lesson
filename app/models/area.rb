class Area < ActiveRecord::Base
  has_many :courses
  attr_accessible :information, :name, :courses
end
