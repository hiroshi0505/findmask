class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  # before_action :move_to_index, except: [:index, :number, :search]

  # includesメソッドを使用するとすべてのレコードを取得するため、allメソッドは省略可能
  def index
    @tweets = Tweet.includes(:user).paginate(page: params[:page], per_page: 10).order('created_at DESC') # ASC（昇順）
    # @tweets = Tweet.includes(:user).paginate(page: params[:page], per_page: 3) # ASC（昇順）
  end

  # Tweetクラスのインスタンス変数を生成します。
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to action: :show
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
    @tweet = Tweet.find_by(id: params[:id])
    @likes_count = Like.where(tweet_id: @tweet.id).count
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def number
  end

  private

  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # def move_to_index
  #   redirect_to action: :index unless user_signed_in?
  # end
end
