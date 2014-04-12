class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :namesasds
      t.string :email
      t.boolean :verified_type
      t.string :password
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.references :sub, polymorphic: true

      t.timestamps
    end
  end
end
