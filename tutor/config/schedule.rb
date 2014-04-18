every 2.hours do
	@current = 
	Student.all.each do |student|
		#if student.last_sign_in_at > #some value
			runner "SystemReminders.reminder_email(student)"
		#end
	end
end