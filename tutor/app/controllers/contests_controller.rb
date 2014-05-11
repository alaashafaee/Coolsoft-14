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

	def update
		@contest  = Contest.find(params[:id])
		if @contest.update(contest_params)
			redirect_to(:action => 'show', :id => @contest.id)
		else
			render :action=>'edit'
		end
	end

	private
		def contest_params 
			params.require(:contest).permit(:title, :description, :course, :start_date, :start_time,
				:end_date, :end_time)
		end

end
