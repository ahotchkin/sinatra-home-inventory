class Category <ActiveRecord::Base
  validates_presence_of :name
  has_many :item_categories
  has_many :items, through: :item_categories
  has_many :users, through: :items
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
