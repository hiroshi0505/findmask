require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    before do
      @tweet = FactoryBot.build(:tweet)
    end

    context "投稿が保存できる場合" do
      it "textとimageがあれば投稿は保存される" do
        expect(@tweet).to be_valid
      end
    end
    
    context "投稿が保存できない場合" do
      it 'textが空では投稿は保存できない' do
        @tweet.text = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Text can't be blank")
      end
      it 'imageが空では投稿は保存できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Image can't be blank")
      end
      it "ユーザーが紐付いていないと投稿は保存できない" do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("User must exist")
      end
    end
  end
end
