class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :name
      t.string :profile_image
      t.string :link

	  t.timestamps
    end
  end
end
