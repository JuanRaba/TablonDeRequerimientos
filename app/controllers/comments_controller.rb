class CommentsController < ApplicationController
  def create
    @comment = Comment.new(
      content: params[:comment][:content],
      user: current_user,
      request_id: params[:request_id]
      )

    respond_to do |format|
      if @comment.save
        format.html { redirect_to Request.find(params[:request_id]), notice: 'comment was successfully created.' }
      else
        
        format.html { redirect_to Request.find(params[:request_id]), alert: 'comment was not created.' }
      end
    end
  end
end
