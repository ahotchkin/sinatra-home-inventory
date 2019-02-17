class Group < ActiveRecord::Base
  validates_presence_of :name
  has_many :item_groups
  has_many :items, through: :item_groups
  has_many :users, through: :items
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
