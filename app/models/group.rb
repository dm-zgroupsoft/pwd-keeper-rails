class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Group'
  has_many :children, :class_name => 'Group', :dependent => :destroy
  has_many :entries, :dependent => :destroy

  def as_json(options = {})
    super(only: [:title, :icon, :group_id]).merge(key: id, children: children.as_json)
  end
end
