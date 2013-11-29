class GroupsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        groups = current_user.groups.where(:group_id => nil)
        render :json => groups
      end
    end
  end

  def new
    @group = Group.new(:group_id => params[:group_id])
    render :layout => false
  end

  def edit
    @group = Group.find(params[:id])
    render :layout => false
  end

  def create
    group = current_user.groups.build(params.require(:group).permit!)
    group.save
    render :json => group
  end

  def update
    group = Group.update(params[:id], params.require(:group).permit!)
    render :json => group
  end

  def destroy
    Group.destroy(params[:id])
    render :text => params[:id]
  end
end
