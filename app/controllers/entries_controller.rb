class EntriesController < ApplicationController
  layout false
  def index
    @entries = Entry.where(:group_id => params[:group_id]).to_a
  end

  def new
    @entry = Entry.new
  end
end
