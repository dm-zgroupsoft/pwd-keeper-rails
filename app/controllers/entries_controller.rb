class EntriesController < ApplicationController
  layout false

  def index
    @entries = Entry.where(:group_id => params[:group_id]).order(title: :asc)
  end

  def new
    @groups = current_user.groups.where(:group_id => nil)
    group = Group.find(params[:group_id])
    @entry = group.entries.build
  end

  def edit
    @groups = current_user.groups.where(:group_id => nil)
    @entry = Entry.find(params[:id])
  end

  def update
    Entry.update(params[:id], params.require(:entry).permit!)
    render :nothing => true
  end

  def create
    entry = Entry.new(params.require(:entry).permit!)
    entry.save
    render :json => entry
  end

  def destroy
    Entry.destroy(params[:id])
    render :nothing => true
  end
end
