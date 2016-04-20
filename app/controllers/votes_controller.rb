class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
    @poll = Poll.find(params[:poll_id])
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @poll = Poll.find(params[:poll_id])
    @vote = @poll.votes.create(vote_params)
    @vote.generate_token()
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @poll, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def wanttovote
    token = params[:token]
    vote_link = Vote.find_by(token: token)
    if !vote_link.nil? && vote_link.usable?
    	@poll = vote_link.poll
        @myvote = Myvote.new()
    else
        if !vote_link.nil?
          @poll = vote_link.poll
       		respond_to do |format|
		format.html { redirect_to poll_view_path(@poll) }
                end
        else
          respond_to do |format|
                format.html { redirect_to root_path, notice: 'Ce lien a déjà été utilisé ou a expiré' }
                end
        end
    end
  end
  def ivote
      token = params[:token]
    vote_link = Vote.find_by(token: token)
    if !vote_link.nil? && vote_link.usable?
         respond_to do |format|
            if params[:myvote][:clef] != vote_link.clef
                format.html { redirect_to wanttovote_path(:token => token), notice: 'La clef ne correspond pas' }
            else
                @poll = vote_link.poll
                selected_candidate = Candidate.find_by(poll_id: @poll, user_id: params[:myvote][:candidate_id])
                if !selected_candidate.votes.nil?
                 selected_candidate.votes = selected_candidate.votes + 1
                else
                 selected_candidate.votes = 1
                end
                if selected_candidate.save
                 vote_link.set_used
                 format.html { redirect_to root_path, notice: 'Merci pour ton vote' }
                else
                 format.html {redirect_to wanttovote_path(:token => token), notice: 'Erreur avec ton vote' }
                end
            end
          end  
    else
                respond_to do |format|
                format.html { redirect_to root_path, notice: 'Ce lien a déjà été utilisé ou a expiré' }
                end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params[:vote]
    end
end
