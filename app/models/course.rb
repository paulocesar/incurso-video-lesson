class Course < ActiveRecord::Base
  belongs_to :area
  belongs_to :user
  # has_and_belongs_to_many :packages
  has_many :videos
  attr_accessible :discount, :information, :name, :area, :user, :videos, :area_id, :user_id#, :packages

  def screenshot
    return nil if !videos.first
    videos.first.panda_video.encodings["h264"].screenshots.first
  end
end
