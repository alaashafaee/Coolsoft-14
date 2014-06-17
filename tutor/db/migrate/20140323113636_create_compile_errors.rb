class CreateCompileErrors < ActiveRecord::Migration
  def change
    create_table :compile_errors do |t|

      t.timestamps
    end
  end
end
