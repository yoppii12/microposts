class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
      
      #emailにユニークインデックスを追加しメールアドレスが他と異なるようにする
      t.index :email, unique: true
    end
  end
end
