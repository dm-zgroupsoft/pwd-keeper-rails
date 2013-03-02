class Group < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Group'
  has_many :children, :class_name => 'Group', :dependent => :destroy

  attr_accessible :title, :icon, :position, :group_id

  def as_json(options = {})
    # jsTree plugin requires exact json structure
    {:data => {:title => self.title, :icon => self.icon}, :attr => {:id => self.id}, :children => self.children.as_json}
  end
end
