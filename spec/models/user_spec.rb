require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'バリデーションテスト' do

    ####################################################################################################
    # 名前
    ####################################################################################################
    context 'name' do
      # let(:user) { User.new(name: name, email: "test@example.com", password: "password") }

      context '空の場合' do
        it 'エラー「名前を入力してください」が出力されること' do
          user = build(:user, name: "")
          user.save
          name_required_msg = ["名前を入力してください"]
          expect(user.errors.full_messages).to eq name_required_msg
        end
      end

      context '30文字超の場合' do
        it 'エラー「名前は30文字以内で入力してください」が出力されること' do
          user = build(:user, name: "a" * 31)
          user.save
          name_maxlength_msg = ["名前は30文字以内で入力してください"]
          expect(user.errors.full_messages).to eq name_maxlength_msg
        end
      end

      context '30文字の場合' do
        it 'ユーザが保存でき、1人増えること' do
          user = build(:user, name: "a" * 30)
          expect{ user.save }.to change{ User.count }.by(1)
        end
      end
    end

    ####################################################################################################
    # メールアドレス
    ####################################################################################################
    context 'email' do

      context '空の場合' do
        it 'エラー「メールアドレスを入力してください」が出力されること' do
          user = build(:user, email: "")
          user.save
          email_required_msg = ["メールアドレスを入力してください"]
          expect(user.errors.full_messages).to eq email_required_msg
        end
      end

      context '255文字超の場合' do
        max = 255
        domain = "@example.com"
        it 'エラー「メールアドレスは255文字以内で入力してください」が出力されること' do
          user = build(:user, email: "a" * ((max + 1) - domain.length) + domain)
          user.save
          email_maxlength_msg = ["メールアドレスは255文字以内で入力してください"]
          expect(user.errors.full_messages).to eq email_maxlength_msg
        end
      end

      context '正しい書式の場合' do
        context 'ユーザが保存でき、1人増えること' do
          ok_emails = %w(
            A@EX.COM
            a-_@e-x.c-o_m.j_p
            a.a@ex.com
            a@e.co.js
            1.1@ex.com
            a.a+a@ex.com
          )
          ok_emails.each do |email|
            it "パターン: #{email}" do
              user = build(:user, email: email)
              # by(6)のようにベタ書きにするとパターンを追加した時にby(7)にする必要が出るのでby(1)
              expect{ user.save }.to change{ User.count }.by(1)
            end
          end
        end
      end

      context '誤った書式の場合' do
        context 'ユーザは保存されず、エラー「メールアドレスは不正な値です」が出力されること' do
          ng_emails = %w(
            aaa
            a.ex.com
            メール@ex.com
            a~a@ex.com
            a@|.com
            a@ex.
            .a@ex.com
            a＠ex.com
            Ａ@ex.com
            a@?,com
            １@ex.com
            "a"@ex.com
            a@ex@co.jp
          )
          ng_emails.each do |email|
            email_format_msg = ["メールアドレスは不正な値です"]
            it "パターン: #{email}" do
              user = build(:user, email: email)
              expect{ user.save }.to change{ User.count }.by(0)
              expect(user.errors.full_messages).to eq email_format_msg
            end
          end
        end
      end

      context '大文字の場合' do
        it '小文字に変換され、保存されること' do
          user = build(:user, email: "USER@EXAMPLE.COM")
          email = user.email
          user.save
          expect(user.email).to eq email.downcase
        end
      end

      context '同じemailをもつユーザが有効化されていない場合' do
        count = 3
        (1..count).each do |c|
          it "ユーザが保存でき、1人増えること: #{c}回目" do
            user = build(:user, email: "test@example.com")
            expect{ user.save }.to change{ User.count }.by(1)
          end
        end
      end
    end
  end

  describe '各アクションのテスト' do
    context 'ユーザを削除した場合' do
      it '投稿も同時に削除されること' do
        user = create(:user)
        post = create(:post, user_id: user.id)
        expect { user.destroy }.to change { Post.count }.by(-1)
      end
    end
  end

end


      # skip
      # --
      # context '同じemailをもつユーザが有効化されている場合' do
      #   let(:email) { "test@example.com" }
      #   let(:activated) { true }
      #   duplicate_email_msg = ["メールアドレスはすでに存在します"]
      #   count = 3
      #   (1..count).times do
      #     user.save
      #     it "エラー「メールアドレスはすでに存在します」が出力されること: #{c}回目" do
      #       user.save
      #       expect(user.errors.full_messages).to eq duplicate_email_msg
      #     end
      #   end
      # end

      # context 'アクティブユーザがいなくなった場合' do
      # context '一意性は保たれているか' do

      # next
      # --
      # Factory_botの導入
      # config.include FactoryBot::Syntax::Methods を記述するとよい
