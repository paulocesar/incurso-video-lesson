class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :description
  has_many :videos
  has_and_belongs_to_many :purchased_videos,
    :class_name => 'Video',
    :join_table => 'users_videos',
    :foreign_key => 'user_id',
    :association_foreign_key => 'video_id',
    :uniq => true
  has_and_belongs_to_many :owners,
    :class_name => 'User',
    :join_table => 'owners_friends',
    :foreign_key => 'friend_id',
    :association_foreign_key => 'owner_id',
    :uniq => true
  has_and_belongs_to_many :friends,
    :class_name => 'User',
    :join_table => 'owners_friends',
    :foreign_key => 'owner_id',
    :association_foreign_key => 'friend_id',
    :uniq => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
         :role, :description, :purchased_videos, :videos
  # attr_accessible :title, :body

  def is_admin?
    return true if self.role.name == 'Administrador'
    false
  end

  def is_university?
    return true if self.role.name == 'Universidade'
    false
  end

  def is_teacher?
    return true if self.role.name == 'Professor'
    false
  end

  def can_add_courses?
    return true if is_admin? || is_university? || is_teacher?
    return false
  end

  def teachers
    return nil if !is_university?
    teachs = User.joins("LEFT JOIN owners_friends ON owners_friends.friend_id = users.id").joins("LEFT JOIN users AS owner ON owner.id = owners_friends.owner_id").joins("LEFT JOIN roles ON roles.id = owner.role_id").where(['roles.name LIKE "Administrador" AND owner.id = ?',self.id])
    teachs.empty? ? nil : teachs
  end

  def students
    return nil if !is_university?
    teachs = User.joins("LEFT JOIN owners_friends ON owners_friends.friend_id = users.id").joins("LEFT JOIN users AS owner ON owner.id = owners_friends.owner_id").joins("LEFT JOIN roles ON roles.id = owner.role_id").where(['roles.name LIKE "Aluno" AND owner.id = ?',self.id])
    teachs.empty? ? nil : teachs
  end
end
