class PollController < ApplicationController
  def index
    authorize! :read, :admin
    @polls = Poll.all
  end
  def new
  @poll = Poll.new
  end

  def edit
  end

  def view
  end
end
