class FavoritesController < ApplicationController
     before_action :logged_in_user
    
    #お気に入りする他のユーザーのIDをパラメータとして受け取り、見つかったユーザーを引数としてUserモデルのfavoriteメソッドを実行
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.favorite(@micropost)
    end
    
    #現在のユーザーのfavorite_relationshipsを検索して他のユーザーの投稿をお気に入りしている場合は、そのユーザーを引数としてUserのunfavoriteメソッドを実行
   def destroy
        @micropost = current_user.favorite-relationships.find(params[:id]).user
        current_user.unfavorite(@micropost)
   end
end
