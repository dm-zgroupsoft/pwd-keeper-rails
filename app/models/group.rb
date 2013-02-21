class Group < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Group', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'Group'

  attr_accessible :title, :icon
end
