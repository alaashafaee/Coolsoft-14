class DashboardControllerController < ApplicationController

def show 
		if lecturer_signed_in?
		@notifications = Lecturer.find(params[:id]).notifications.order("created_at desc")	
		elsif teaching_assistant_signed_in?
		@notifications = TeachingAssistant.find(params[:id]).notifications.order("created_at desc")
		else
		@notifications = Student.find(params[:id]).notifications.order("created_at desc")
		end
  
end 

end
