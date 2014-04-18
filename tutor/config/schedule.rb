every 2.days do
	@current = 
	Student.all.each do |student|
		if student.last_sign_in_at > Time.now - 7.days
			runner "SystemReminders.reminder_email(student).deliver"
		end
	end
end