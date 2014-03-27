class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.boolean :verified_type
      t.string :password
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.string :department
      t.string :staff

      t.timestamps
    end
  end
end
