class CreateStuffs < ActiveRecord::Migration
  def change
    create_table :stuffs do |t|
      t.string :department
      t.string :stuff

      t.timestamps
    end
  end
end
