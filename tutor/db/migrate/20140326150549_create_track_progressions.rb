class CreateTrackProgressions < ActiveRecord::Migration
  def change
    create_table :track_progressions do |t|
      t.integer :level
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
    add_index(:track_progressions, [:user_id,:topic_id], :unique => true)
  end
end
