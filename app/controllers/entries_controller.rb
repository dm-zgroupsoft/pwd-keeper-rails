class EntriesController < ApplicationController
  layout false
  def index
    @entries = Entry.where(:group_id => params[:group_id]).order(title: :asc)
  end

  def new
    @group = Group.find(params[:group_id])
    @entry = @group.entries.build
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    entry = Entry.new(params.require(:entry).permit!)
    entry.save
    render :json => entry
  end
end
