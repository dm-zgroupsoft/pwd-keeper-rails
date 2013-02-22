class Group < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Group'
  has_many :children, :class_name => 'Group'

  attr_accessible :title, :icon, :position, :group_id

  def as_json(options = {})
    {:data => {:title => self.title, :icon => 'folder'}, :attr => {:id => self.id}, :children => self.children.as_json}
  end
end
