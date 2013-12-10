class Group < ActiveRecord::Base
  belongs_to :user
  has_many :entries, :dependent => :destroy

  acts_as_tree :order => 'sort_order', :dependent => :destroy, :with_advisory_lock => false

  def as_json(options = {})
    super(only: [:title, :parent_id]).merge(key: id, addClass: "custom-dynatree-icon-base custom-dynatree-icon-#{icon}")
  end

  def self.json_tree(nodes = nil)
    nodes = hash_tree.values[0] unless nodes
    nodes.map do |node, sub_nodes|
      node.as_json.merge(children: json_tree(sub_nodes).compact)
    end
  end

  def self.arrange_as_array(groups = nil)
    groups = hash_tree.values[0] unless groups
    result = []
    groups.each do |node, children|
      result << ['&nbsp;&nbsp;' * node.depth + node.title, node.id, {'data-icon' => "icon-base icon-#{node.icon}"}]
      result += arrange_as_array children
    end
    result
  end
end
