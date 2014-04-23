class SystemReminders < ActionMailer::Base
	default from: "from@example.com"
	# [System Reminders - Story 5.4]
	# Sends reminder e-mail to given user
	# Parameters:
	# 	user: user instance
	# Returns: none
	# Author: Amir George
	def reminder_email(user)
		@user = user
		@url  = 'http://localhost:3000'
		mail(to: @user.email, subject: 'We miss you at our Awesome Tutors Website')
	end
end
