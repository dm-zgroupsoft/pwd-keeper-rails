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

  def move
    source = Group.find(params[:id])
    target = Group.find(params[:target_id])
    mode = params[:mode]
    if mode == 'over'
      target.add_child(source)
    elsif mode == 'after'
      target.append_sibling(source)
    else
      target.prepend_sibling(source)
    end
    render :nothing => true
  end

  def destroy
    Group.destroy(params[:id])
    render :nothing => true
  end
end
