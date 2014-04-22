# for this to work type this the terminal before starting server:
# whenever --update-crontab sendReminders
every 2.days do
	runner "Student.send_reminder_mails"
end