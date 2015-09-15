class SessionsController < ApplicationController
  def new
  end
  
  def create
    #ユーザーをメールアドレスから検索
    @user=User.find_by(email: params[:session][:email].downcase)
    #パスワードが正しいか調べる
    if @user && @user.authenticate(params[:session][:password])
      #パスワードが正しい場合はsession[:user_id]にIDを入れユーザーの詳細ページにリダイレクトする
      session[:user_id]=@user.id
      flash[:info]="logged in as #{@user.name}"
      redirect_to @user
    else flash[:danger]='incalid email/password cobination'
      #パスワードが間違っている場合はnewテンプレートを表示
      render'new'
    end
  end
  
  def destroy
    #session[]をnilにし、サーバーとブラウザの両方でセッションの情報が破棄される
    session[:user_id]=nil
    #アプリケーションのルート/にリダイレクトする
    redirect_to root_path
  end
end
