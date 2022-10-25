require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'バリデーションテスト' do

    # ユーザID
    context 'user_id' do
      context '空の場合' do
        it 'エラー「ユーザIDを入力してください」が出力されること' do
          post = build(:post, user_id: "")
          post.save
          user_id_required_msg = ["ユーザIDを入力してください"]
          expect(post.errors.full_messages).to eq user_id_required_msg
        end
      end
    end

    # コンテンツ
    context 'content' do
      context '空の場合' do
        it 'エラー「本文を入力してください」が出力されること' do
          # user = create(:user)
          post = build(:post, content: "")
          post.save
          content_required_msg = ["本文を入力してください"]
          expect(post.errors.full_messages).to eq content_required_msg
        end
      end
      context '300文字を超える場合' do
        it 'エラー「本文は300文字以内で入力してください」が出力されること' do
          # user = create(:user)
          post = build(:post, content: "a" * 301)
          post.save
          content_maxlength_msg = ["本文は300文字以内で入力してください"]
          expect(post.errors.full_messages).to eq content_maxlength_msg
        end
      end
      # context '最新1件を取得する場合' do
      #   it '作成日が最新の1件を取得できること' do
      #     post1 = create(:post)
      #     post2 = create(:post)  # 作成日が最新
      #     expect(post2).to eq Post.first
      #   end
      # end
    end
  end
end
