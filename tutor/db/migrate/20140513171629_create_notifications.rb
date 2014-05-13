class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message, null:false
      t.boolean :seen, default: false

      t.references :receiver, polymorphic: true
      t.timestamps
    end
  end
end
