require 'rails_helper'
describe Comment do
  before do
    @Comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context 'コメント投稿がうまくいくとき' do
      it "textが存在すればコメント投稿できる" do
        expect(@Comment).to be_valid
      end
    end

    context 'コメント投稿がうまくいかないとき' do
      it "textが空だとコメント投稿できない" do
        @Comment.text = ''
        @Comment.valid?
        expect(@Comment.errors.full_messages).to include("Text can't be blank")
      end
      it "userが紐付いていないとコメント投稿できない" do
        @Comment.user = nil
        @Comment.valid?
        expect(@Comment.errors.full_messages).to include("User must exist")
      end
      it "tweetが紐付いていないとコメント投稿できない" do
        @Comment.tweet = nil
        @Comment.valid?
        expect(@Comment.errors.full_messages).to include("Tweet must exist")
      end
    end
  end
end