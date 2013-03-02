class GroupsController < ApplicationController

  def index
    groups = Group.where(:group_id => nil)
    puts groups.to_json
    render :json => groups
  end

  def create
    group = Group.create(params[:group])
    render :text => group.id
  end

  def destroy
    Group.destroy(params[:id])
    render :nothing => true
  end
end
