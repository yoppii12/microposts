class Relationship < ActiveRecord::Base
  #userクラスのオブジェクトなのでclass_nameでUserを指定
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
