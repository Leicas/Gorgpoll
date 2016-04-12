class PollController < ApplicationController
  def index
    authorize! :read, :admin
  end
  def new
  end

  def edit
  end

  def view
  end
end
