class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :img
      t.text :content
      t.integer :views_count
      t.integer :discussion_board_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
