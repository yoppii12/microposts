class UsersController < ApplicationController
  
  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts
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
  
  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'プロフィールを編集しました。'
    else
      flash.now[:alert]="プロフィール情報を入力してください。"
      render 'edit'
    end
  end
  
  def followings
    #現在ログインしているユーザー（自分のＩＤ）を取得）
    @user=User.find(params[:id])
    @followings=@user.following_users
  end
  
  def followers
    @user=User.find(params[:id])
    @followers=@user.follower_users
  end
  
  def favorite_items
    if logged_in?
      @micropost=Favorite.find(params[:micropost_id])
      @user=@micropost.user_id
    end
  end
  
  private
  #ストロングパラメーターの設定
  # params[:user]のパラメータで name, email, password, password_confirmationのみを許可する
  def user_params
    params.require(:user).permit(:name, :email, :age, :area, :password, :password_confirmation)
  end
end
