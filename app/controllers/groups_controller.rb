class GroupsController < ApplicationController

  def index
    groups = current_user.groups.where(:group_id => nil)
    render :json => groups
  end

  def create
    group = current_user.groups.build(params[:group])
    current_user.save
    render :text => group.id
  end

  def destroy
    Group.destroy(params[:id])
    render :nothing => true
  end
end
