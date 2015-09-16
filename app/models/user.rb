class User < ActiveRecord::Base
    #[コールバック]データの保存前にメールアドレスのアルファベッドを小文字にする
    before_save { self.email=email.downcase }
    #nameは空ではなく、最大50文字
    validates :name, presence: true, length: {maximum: 50}
    #メールアドレスの正規表現パターンを定義
    VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #emailは空でなく255文字以内、正規表現パターンに一致、他と異なる
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
    
    #機能
    #データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存
    #passwordとpassword_confirmationをモデルに追加して、パスワードの確認が一致するか検証
    #パスワードが正しいときに、ユーザーを返すauthenticateメソッドを提供
    has_secure_password
    #それぞれのユーザーは複数の投稿を持つ
    has_many :microposts
end
