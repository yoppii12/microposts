class Micropost < ActiveRecord::Base
  #それぞれの投稿は特定の1人のユーザーのもの
  belongs_to :user
  #user_idが存在、contentが存在し文字数は最大140
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140 }
end
