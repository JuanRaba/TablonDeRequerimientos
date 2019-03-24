class RequestsController < ApplicationController
  before_action :set_request, only: [:show]
  helper_method :sort_column, :sort_direction
  
  def index
    # needed as we have the request form in index
    @request = Request.new
    @requests2 = Request.order(sort_column + " " + sort_direction)    
  end

  def show
    # needed as we have the comment form in show
    @comment = Comment.new
    @comments = Comment.all
  end
  def create
    @request = Request.new(request_params)
    @request.user = current_user

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :index }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def voteup
    vote(1)
    redirect_to root_path, notice: 'voteup'
  end

  def votedown
    vote(-1)
    redirect_to root_path, notice: 'votedown'
  end

  private

  def sort_column
    Request.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def vote(value)
    @request = Request.find(params[:request_id])
    @vote = Vote.where(request: @request, user: current_user).first
    previous_vote_value = 0
    if @vote
      # if vote already exits, save previous_vote_value to undo vote value
      previous_vote_value = @vote.value
      @vote.value = value
    else
      # if vote doest exist, create it and increase popularity 
      @vote = Vote.create(request: @request, user: current_user, value: value)
      @request.popularity += 1
    end

    ActiveRecord::Base.transaction do
      begin
        @request.score = @request.score + value - previous_vote_value
        @request.save!
        @vote.save!
      rescue
        redirect_to root_path, alert: 'try again, concurrency error ocurred'
      end
    end
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :content)
  end
end
