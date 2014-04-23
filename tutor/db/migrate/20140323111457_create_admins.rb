class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.date :dob
      t.string :profile_image
      t.boolean :gender
      
      t.timestamps
    end
  end
end
