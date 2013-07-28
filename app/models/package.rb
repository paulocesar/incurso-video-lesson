class Package < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :courses
  attr_accessible :discount, :information, :name, :courses, :user
end
