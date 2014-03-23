class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :views_count
      t.integer :discussion_board_id
      t.integer :user_id

      t.timestamps
    end
  end
end
