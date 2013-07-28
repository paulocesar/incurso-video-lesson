class Video < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_and_belongs_to_many :buyers,
    :class_name => 'User',
    :join_table => 'users_videos',
    :foreign_key => 'video_id',
    :association_foreign_key => 'user_id',
    :uniq => true
  attr_accessible :information, :name, :panda_video, 
  :panda_video_id, :price, :user, :course, :course_id, :buyers, :user_id

  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end

  def self.video_by_user_permission video_id, user_id
    @video = self.all(
      :include => :buyers,
      :conditions => [
        "users.id = ? AND videos.id = ?",
        user_id,
        video_id
      ]
    )

    if @video.empty?
      @video = self.find_by_id_and_user_id(video_id,user_id)
    else
      @video = @video.first
    end

    @video
  end

end
