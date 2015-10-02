class User < ActiveRecord::Base
    #[コールバック]データの保存前にメールアドレスのアルファベッドを小文字にする
    before_save { self.email=email.downcase }
    #nameは空ではなく、最大50文字
    validates :name, presence: true, length: {maximum: 50}
    #メールアドレスの正規表現パターンを定義
    VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #emailは空でなく255文字以内、正規表現パターンに一致、他と異なる
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
    
    validates :area,presence: true, length: {maximum: 100}, on: :update
    
    validates :age , length: {minimum: 1 } , numericality: {only_integer: true, greater_than_or_equal_to: 0}, on: :update
    
    #機能
    #データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存
    #passwordとpassword_confirmationをモデルに追加して、パスワードの確認が一致するか検証
    #パスワードが正しいときに、ユーザーを返すauthenticateメソッドを提供
    has_secure_password
    #それぞれのユーザーは複数の投稿を持つ
    has_many :microposts
    
    #あるユーザーがフォローしている人を取得
    has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    #あるユーザーをフォローしている人を取得
    has_many :follower_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    # 他のユーザーをフォローする
      def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
      end
    
      # フォローしているユーザーをアンフォローする
      def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
      end
    
      # あるユーザーをフォローしているかどうか？
      def following?(other_user)
        following_users.include?(other_user)
      end
    
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    has_many :favorite_relationships, class_name: "Favorite", foreign_key: "user_id", dependent: :destroy
    has_many :favorite_microposts, through: :favorite_relationships, source: :favorite
    
    
    #あるユーザーの投稿をお気に入りに追加する
    def favorite(other_micropost)
      favorite_relationships.create(micropost_id: other_micropost.id)
    end
    
    #あるユーザーの投稿をお気に入りから削除する
    def unfavorite(other_micropost)
      favorite_relationships.find_by(micropost_id: other_micropost.id).destroy
    end
    
    def favoriting?(other_micropost)
      favorite_microposts.include?(other_micropost)
    end
    
end










