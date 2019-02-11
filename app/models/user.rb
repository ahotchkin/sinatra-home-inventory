class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :items
  has_many :categories, through: :items
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
