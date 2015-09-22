class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    #フォローする他のユーザーのIDをパラメータとして受け取り、見つかったユーザーを引数としてUserモデルのfollowメソッドを実行
    def create
        @user=User.find(params[:followed_id])
        current_user.follow(@user)
    end
    
    #現在のユーザーのfollowing_relationshipsを検索して他のユーザーをフォローしている場合は、そのユーザーを引数としてUserのunfollowメソッドを実行
    def destroy
        @user=current_user.following_relationships.find(params[:id]).followed_id
        current_user.unfollow(@user)
    end
    
end
