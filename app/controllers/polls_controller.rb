class PollsController < ApplicationController
  def index
    authorize! :read, :admin
    @polls = Poll.all
  end
  def new
  @poll = Poll.new
  end
 # POST /polls
  def create
    @poll = Poll.new(poll_params)
    authorize! :create, @poll
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: I18n.translate('users.flash.create.success', user: @poll.title) }
      else
        format.html { render :new, notice: I18n.translate('users.flash.create.fail') , status: :unprocessable_entity }
      end
    end
  end
  def edit
  end

  def view
  end
   private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title, :managerid, :datestart, :datefinish, :id, :datepublish)
    end
end
