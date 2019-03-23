class RequestsController < ApplicationController
  before_action :set_request, only: [:show]

  def index
    # needed as we have the request form in index
    @request = Request.new
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

  private
  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :content)
  end
end
