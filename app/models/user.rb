require "validator/email_validator"

class User < ApplicationRecord
  # Token生成モジュール
  include TokenGenerateService
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # validates: xxが呼ばれる前に実行される
  before_validation :downcase_email

  has_secure_password
  validates :name, presence: true,
        length: {
          maximum: 30,
          allow_blank: true
        }
  validates :email, presence: true,
        email: { allow_blank: true }
  # 「a-zA-Z0-9_-」に一致する8文字以上
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
              length: {
                minimum: 8,
                allow_blank: true
              },
              format: {
                with: VALID_PASSWORD_REGEX,
                message: :invalid_password,
                allow_blank: true
              },
              allow_nil: true
  class << self
    # emailからアクティブなユーザーを返す
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end
  end

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update!(refresh_jti: jti)
  end

  # リフレッシュトークンのJWT IDを削除する
  def forget
    update!(refresh_jti: nil)
  end

  # ユーザオブジェクトの共通のJSONレスポンスを返す(キーの型を統一)
  def response_json(payload = {})
    as_json(only: [:id, :name]).merge(payload).with_indifferent_access
  end

  private

    def downcase_email
      self.email.downcase! if email
    end
end
