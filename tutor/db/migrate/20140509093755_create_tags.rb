class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.references :tager, polymorphic: true
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
