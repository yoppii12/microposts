class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      t.index [:user_id, :create_at]
    end
  end
end
