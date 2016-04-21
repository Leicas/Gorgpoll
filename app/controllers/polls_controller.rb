class PollsController < ApplicationController
 before_action :set_poll, only: [:show, :edit, :update, :destroy, :sync_with_gram  ]
  def index
    authorize! :read, :admin
    @polls = Poll.all
  end
  def new
  @poll = Poll.new
  @users = User.all
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
   authorize! :update, @poll
   @users = User.all
  end
  def update
    authorize! :update, @poll

    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: I18n.translate('polls.flash.update.success', poll: @poll.title) }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit, notice: I18n.translate('polls.flash.update.fail', poll: @poll.title) , status: :unprocessable_entity}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    authorize! :read, @poll=(params[:id] ?  Poll.find(params[:id]) : current_poll)
    @candidates = @poll.candidates
    @votes = @poll.votes
  end
  def view
  @poll=Poll.find(params[:id])
  @total = 0
  @poll.candidates.each do |candidate|
   if !candidate.votes.nil?
    @total += candidate.votes
    end
   end
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
      params.require(:poll).permit(:title, :description, :user_id, :datestart, :datefinish, :id, :datepublish)
    end
end
