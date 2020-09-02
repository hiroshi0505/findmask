class CommentsController < ApplicationController
  def create
    # binding.pry
    comment = Comment.create(comment_params)
    render json: { comment: comment }
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
