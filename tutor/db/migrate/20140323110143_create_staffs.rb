class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :department
      t.string :staff

      t.timestamps
    end
  end
end
