class EntriesController < ApplicationController
  layout false

  def index
    @entries = Entry.where(:group_id => params[:group_id]).order(title: :asc)
  end

  def new
    @groups = Group.where(user: current_user).arrange_as_array
    group = Group.find(params[:group_id])
    @entry = group.entries.build
  end

  def edit
    @groups = Group.where(user: current_user).arrange_as_array
    @entry = Entry.find(params[:id])
  end

  def update
    Entry.update(params[:id], params.require(:entry).permit!)
    render :nothing => true
  end

  def create
    Entry.create(params.require(:entry).permit!)
    render :nothing => true
  end

  def destroy
    Entry.destroy(params[:id])
    render :nothing => true
  end
end
