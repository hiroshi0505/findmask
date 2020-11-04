class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, tweet_id: params[:tweet_id])
    @like.save
    # 投稿詳細ページにリダイレクト
    redirect_to("/tweets/#{params[:tweet_id]}")
  end
  
  def destroy
    @like = Like.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    @like.destroy
    # 投稿詳細ページにリダイレクト
    redirect_to("/tweets/#{params[:tweet_id]}")
  end
end