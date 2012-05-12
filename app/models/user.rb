class User < ActiveRecord::Base
  attr_accessible :bio, :email, :firstname, :lastname, :nickname

  validates :nickname, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
    
  # Following
  has_many :following, :through => :relationships, :source => :followed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  
  # Followers
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  
  
  def following?(followed)
    self.relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    self.relationships.create!(:followed_id => followed.id) unless following?(followed)
  end

  def unfollow!(followed)
    self.relationships.find_by_followed_id(followed).destroy if following?(followed)
  end
  
end
