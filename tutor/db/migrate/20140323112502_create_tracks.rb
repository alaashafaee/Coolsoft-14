class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :difficulty
      t.integer :views_count, default: 0
      t.integer :topic_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
