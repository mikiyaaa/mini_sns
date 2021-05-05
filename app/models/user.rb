class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :sns_credentials

  def self.from_omniauth(auth)
    # sns認証したことがあればテーブルから情報を取得、なければ新しくインスタンスを保存
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create

    # sns認証したことがなければemailでユーザー検索して取得 or ビルド（保存はしない）
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
  end
end
