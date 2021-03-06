class Item < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  has_many :item_groups
  has_many :groups, through: :item_groups
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
