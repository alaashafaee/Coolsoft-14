class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.boolean :verified_type
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.timestamps
    end
  end
end
