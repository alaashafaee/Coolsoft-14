class CreateNotificationMails < ActiveRecord::Migration
  def change
    create_table :notification_mails do |t|
      t.string :subject
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
