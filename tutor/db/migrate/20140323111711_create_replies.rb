class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.string :img
      t.integer :post_id
      
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
