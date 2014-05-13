class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message, nil:false
      t.boolean :seen, defualt: false

      t.references :receiver, polymorphic: true
      t.timestamps
    end
  end
end
