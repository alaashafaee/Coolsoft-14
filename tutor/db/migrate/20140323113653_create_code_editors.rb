class CreateCodeEditors < ActiveRecord::Migration
  def change
    create_table :code_editors do |t|

      t.timestamps
    end
  end
end
