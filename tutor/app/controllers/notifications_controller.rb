class NotificationsController < ApplicationController

def index
	if current_lecturer
		@user = current_lecturer
	elsif current_teaching_assistant
		@user = current_teaching_assistant
	else @user = current_student
	end
	@new_notifications = @user.notifications.where("seen = 'f'")
	@old_notifications = @user.notifications.where("seen = 't'")	
	@user.notifications.where("seen = 'f'").each do |notification|
		notification.seen = 't'
		notification.save
	end
end	
end
