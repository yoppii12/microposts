module SessionsHelper
    
    #ログイン中の場合はログインしているユーザーを、ログインしていない場合はnilを返su
    def current_user
        @current_user ||=User.find_by(id: session[:user_id])
    end
    
    #current_userが存在する場合はtrueを、nilの場合はfalseを返し 
    def logged_in?
        !!current_user
    end
    
    #ログインが必要なページにアクセスしようとした際に、ページのURLを一旦保存しておき、ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合にこのメソッドを使用
    def store_location
        session[:forwarding_url]=request.url if request.get?
    end
end
