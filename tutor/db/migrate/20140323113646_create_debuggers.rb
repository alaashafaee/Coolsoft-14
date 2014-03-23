class CreateDebuggers < ActiveRecord::Migration
  def change
    create_table :debuggers do |t|

      t.timestamps
    end
  end
end
