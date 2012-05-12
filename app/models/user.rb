class User < ActiveRecord::Base
  include Async
  
  attr_accessible :bio, :email, :firstname, :lastname, :nickname

  validates :nickname,  presence: true, uniqueness: true
  validates :email,     presence: true, uniqueness: true
    
  # Following
  has_many :following, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  
  # Followers
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  def following?(followed_id)
    relationships.where(followed_id: followed_id).exists?
  end

  def follow!(followed_id)
    async(:_follow!, followed_id)
  end

  def unfollow!(followed_id)
    async(:_unfollow!, followed_id)
  end

  private 

  def _follow!(followed_id)
    relationships.create!(followed_id: followed_id) rescue nil
  end

  def _unfollow!(followed_id)
    relationships.where(followed_id: followed_id).destroy rescue nil
  end
    
end
