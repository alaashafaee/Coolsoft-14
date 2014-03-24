class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :difficulty
      t.integer :views_count
      t.integer :topic_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
