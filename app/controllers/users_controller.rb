class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    # @tweets = user.tweets.paginate(page: params[:page], per_page: 1).order('created_at DESC') # ASC（昇順）
    @tweets = user.tweets.paginate(page: params[:page], per_page: 1)
  end
end
