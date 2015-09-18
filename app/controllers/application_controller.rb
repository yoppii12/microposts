class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #SessionHelperモジュールの読み込み
  include SessionsHelper
  
  private
  #ログインを促す画面
  def logged_in_user
    #ログインしていない場合（logged_in?がfalseのとき）のみ処理を行う
    unless logged_in?
      #アクセスしようとしたURLを保存
      store_location
      flash[:danger]="Please log in."
      #ログイン画面のURLにリダイレクト
      redirect_to login_url
    end
  end
end
