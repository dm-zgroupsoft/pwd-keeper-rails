class GroupsController < ApplicationController

  def index
    groups = Group.where(:group_id => params[:id].empty? ? nil : params[:id])
    puts groups.to_json
    render :json => groups
  end

  def create
    group = Group.create(params[:group])
    render :text => group.id
  end
end
