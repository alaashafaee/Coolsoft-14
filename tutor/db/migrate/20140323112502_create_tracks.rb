class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :difficulty
      t.integer :views_count

      t.timestamps
    end
  end
end
