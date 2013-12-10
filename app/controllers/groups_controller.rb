class GroupsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: Group.where(user: current_user).json_tree }
    end
  end

  def new
    @group = Group.new(:parent_id => params[:parent_id])
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
    render :nothing => true
  end
end
