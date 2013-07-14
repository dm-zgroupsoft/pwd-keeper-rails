class GroupsController < ApplicationController

  def index
    groups = current_user.groups.where(:group_id => nil)
    render :json => groups
  end

  def create
    group = current_user.groups.build(params.require(:group).permit!)
    group.save
    render :json => group
  end

  def destroy
    Group.destroy(params[:id])
    render :text => params[:id]
  end
end
