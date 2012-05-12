class User < ActiveRecord::Base
  attr_accessible :bio, :email, :firstname, :lastname, :nickname

  validates :nickname, :presence => true
  validates :email, :presence => true
    
  # Following
  has_many :following, :through => :relationships, :source => :followed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  
  # Followers
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
end
