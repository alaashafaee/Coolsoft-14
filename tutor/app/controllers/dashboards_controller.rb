class DashboardsController < ApplicationController

	# [Notification sending-story 2.9]
	# Description: Displays Notifications of the user
	# Parameters:
	#	@notifications: The current notifications of the current user
	# Returns: The view of the notifications
	# Author: Ahmed Atef
	def show 
		if lecturer_signed_in?
			@notifications = Lecturer.find(params[:id]).notifications.order("created_at desc")
		elsif teaching_assistant_signed_in?
			@notifications = TeachingAssistant.find(params[:id])
				.notifications.order("created_at desc")
		else
			@notifications = Student.find(params[:id]).notifications.order("created_at desc")
		end
	end 

end
