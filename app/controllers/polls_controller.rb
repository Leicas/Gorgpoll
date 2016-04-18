class PollsController < ApplicationController
 before_action :set_poll, only: [:show, :edit, :update, :destroy, :sync_with_gram  ]
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
  def show
    authorize! :read, @poll=(params[:id] ?  Poll.find(params[:id]) : current_poll)
    @candidates = @poll.candidates
  end
  def view
  end
  def destroy
    authorize! :destroy, @poll
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice:  I18n.translate('users.flash.destroy.success', user: @poll.title) }
    end
  end
   private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def set_poll
      @poll =(params[:id] ?  Poll.find(params[:id]) : current_poll)
    end
    def poll_params
      params.require(:poll).permit(:title, :description, :managerid, :datestart, :datefinish, :id, :datepublish)
    end
end
