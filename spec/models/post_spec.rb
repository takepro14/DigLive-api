require 'rails_helper'

RSpec.describe Post, type: :model do
  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  describe 'アソシエーションテスト' do
    context '投稿削除時' do
      it '選択したタグも同時に削除されること' do
        user = create(:user)
        post = create(:post, user_id: user.id)
        tag = create(:tag)
        post_tag_map = create(:post_tag_map, post_id: post.id, tag_id: tag.id)
        expect { post.destroy }.to change { PostTagMap.count }.by(-1)
      end
      it '選択したジャンルも同時に削除されること' do
        user = create(:user)
        post = create(:post, user_id: user.id)
        genre = create(:genre)
        post_genre_map = create(:post_genre_map, post_id: post.id, genre_id: genre.id)
        expect { post.destroy }.to change { PostGenreMap.count }.by(-1)
      end
      it 'コメントも同時に削除されること' do
        user = create(:user)
        post = create(:post, user_id: user.id)
        comment = create(:comment, user_id: user.id, post_id: post.id)
        expect { post.destroy }.to change { Comment.count }.by(-1)
      end
      it 'いいねも同時に削除されること' do
        user = create(:user)
        post = create(:post)
        like = create(:like, user_id: user.id, post_id: post.id)
        expect { post.destroy }.to change { Like.count }.by(-1)
      end
      it '通知も同時に削除されること' do
        visitor = create(:user)
        visited = create(:user)
        post = create(:post)
        notification = create(:notification, visitor_id: visitor.id, visited_id: visited.id, post_id: post.id)
        expect { visitor.destroy }.to change { Notification.count }.by(-1)
      end
      it '被通知も同時に削除されること' do
        visitor = create(:user)
        visited = create(:user)
        post = create(:post)
        notification = create(:notification, visitor_id: visitor.id, visited_id: visited.id, post_id: post.id)
        expect { visited.destroy }.to change { Notification.count }.by(-1)
      end
    end
  end

  ####################################################################################################
  # バリデーション
  ####################################################################################################
  describe 'バリデーションテスト' do
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
