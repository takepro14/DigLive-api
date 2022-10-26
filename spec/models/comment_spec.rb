require 'rails_helper'

RSpec.describe Comment, type: :model do
  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  describe 'アソシエーションテスト' do
    context 'コメント削除時' do
      it '通知も同時に削除されること' do
        visitor = create(:user)
        visited = create(:user)
        post = create(:post)
        comment = create(:comment, user_id: visitor.id, post_id: post.id)
        notification = create(:notification, visitor_id: visitor.id, visited_id: visited.id, comment_id: comment.id)
        expect { comment.destroy }.to change { Notification.count }.by(-1)
      end
    end
  end
  ####################################################################################################
  # バリデーション
  ####################################################################################################
  describe 'バリデーションテスト' do
    context 'comment' do
      context '空の場合' do
        it 'エラー「コメントを入力してください」が出力されること' do
          user = create(:user)
          post = create(:post, user_id: user.id)
          comment = build(:comment, user_id: user.id, post_id: post.id, comment: "")
          comment.save
          comment_required_msg = ["コメントを入力してください"]
          expect(comment.errors.full_messages).to eq comment_required_msg
        end
      end
      context '300文字を超える場合' do
        it 'エラー「コメントは300文字以内で入力してください」が出力されること' do
          user = create(:user)
          post = create(:post, user_id: user.id)
          comment = build(:comment, user_id: user.id, post_id: post.id, comment: "*" * 301)
          comment.save
          comment_maxlength_msg = ["コメントは300文字以内で入力してください"]
          expect(comment.errors.full_messages).to eq comment_maxlength_msg
        end
      end
      context '300文字以内の場合' do
        it 'コメントが保存でき、1件増えること' do
          user = create(:user)
          post = create(:post, user_id: user.id)
          comment = build(:comment, user_id: user.id, post_id: post.id, comment: "*" * 300)
          expect{ comment.save }.to change{ Comment.count }.by(1)
        end
      end
    end
  end
end