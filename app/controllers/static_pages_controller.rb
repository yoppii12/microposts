class StaticPagesController < ApplicationController
  #ログインしている場合は、新しいMicropostクラスのインスタンスをuser_idを紐付けた状態で初期化
  #current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じ
  
  def home
    if logged_in?
      @micropost = current_user.microposts.build if logged_in?
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
