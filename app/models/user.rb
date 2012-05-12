class User < ActiveRecord::Base
  attr_accessible :bio, :email, :firstname, :lastname, :nickname
end
