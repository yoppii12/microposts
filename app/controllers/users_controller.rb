class UsersController < ApplicationController
  
  def show
    @user=User.find(params[:id])
  end
  
  def new
    #UsersControllerのインスタンス変数@userに代入している
    @user=User.new
  end
  
  #送信されたパラメータの内容をもとに新しい@userのデータを作成
  def create
    @user=User.new(user_params)
    if @user.save
      #一時的なメッセージを表示
      flash[:success]="Welcome to the Sample App!"
      #redirect_to @user_path(@user)と同じように動作
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  #ストロングパラメーターの設定
  # params[:user]のパラメータで name, email, password, password_confirmationのみを許可する
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
