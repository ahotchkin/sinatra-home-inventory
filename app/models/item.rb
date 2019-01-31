class Item < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
