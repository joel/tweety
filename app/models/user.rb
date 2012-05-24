class User < ActiveRecord::Base
  include Async
  
  # self.queue = 'follow'
  
  attr_accessible :bio, :email, :firstname, :lastname, :nickname
  
  validates :nickname,  presence: true, uniqueness: true
  validates :email,     presence: true, uniqueness: true
    
  # Following
  # People i follow
  has_many :following, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  
  # Followers
  # People following me
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  #
  # I follow this person ?
  #
  def following?(followed_id)
    relationships.where(followed_id: followed_id).exists?
  end
    
  #
  # This person following me ?
  #
  def followers?(follower_id)
    raise "no implmented yet !"
  end
    
  #
  # I want follow this person !
  #
  def _follow!(followed_id)
    relationships.create(followed_id: followed_id)
  end

  #
  # I won't follow this person anymore...
  #
  def _unfollow!(followed_id)
    relationship = relationships.where(followed_id: followed_id).first.destroy rescue nil
  end
  
end
