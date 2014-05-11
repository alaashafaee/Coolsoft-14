class ContestsController < ApplicationController
	def edit
		if student_signed_in?
			render ('public/404')
		end
		@contest = Contest.find(params[:id])
		if lecturer_signed_in?
			if !current_lecturer.contests.include?(@contest)
				render ('public/404')
			end
		elsif teaching_assistant_signed_in?
			if !current_teaching_assistant.contests.include?(@contest)
				render ('public/404')
			end
		end
		
	end
end
