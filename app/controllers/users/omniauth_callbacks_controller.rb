# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  private
  def authorization
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # Userモデルのfrom_omniauthメソッドを呼び出す

    if @user.persisted? #DBに保存済みであればtrue、新規登録ではなくログイン処理へ
      sign_in_and_redirect @user, event: :authentication
    else # ユーザー未登録の場合は、新規登録画面へ遷移する
      render template: 'devise/registrations/new'
    end

  end
end
