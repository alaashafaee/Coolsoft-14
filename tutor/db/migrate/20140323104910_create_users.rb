class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.string :type

      t.timestamps
    end
  end
end
