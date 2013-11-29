class EntriesController < ApplicationController
  layout false
  def index
    @entries = Entry.where(:group_id => params[:group_id]).to_a
  end

  def new
    @group = Group.find(params[:group_id])
    @entry = @group.entries.build
  end

  def edit
    @entry = Entry.find(params[:id])
  end
end
