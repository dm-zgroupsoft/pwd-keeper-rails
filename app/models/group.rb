class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Group'
  has_many :children, :class_name => 'Group', :dependent => :destroy
  has_many :entries, :dependent => :destroy
  attr_accessor :activate

  def as_json(options = {})
    super(only: [:title, :group_id]).merge(activate: activate, key: id, addClass: "custom-dynatree-icon-base custom-dynatree-icon-#{icon}", url: Rails.application.routes.url_helpers.group_entries_path(id), children: children.as_json)
  end
end
