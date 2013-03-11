class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable
  has_many :groups

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end
