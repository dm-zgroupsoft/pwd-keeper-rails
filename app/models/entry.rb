class Entry < ActiveRecord::Base
  belongs_to :group

  attr_accessible :group_id, :icon, :login, :notes, :password, :title, :url
end
