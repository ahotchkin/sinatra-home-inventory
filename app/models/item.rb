class Item < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  has_many :item_categories
  has_many :categories, through: :item_categories
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
