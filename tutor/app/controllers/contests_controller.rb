class ContestsController < ApplicationController

	def new
		if(@new_contest == nil)
			@new_contest = Contest.new
		end
	end

	def create
		@new_contest  = Contest.new
		@new_contest.title = contest_params[:title]
		@new_contest.course_id = contest_params[:course_id]
		@new_contest.description = contest_params[:description]
		@new_contest.expiration_date = contest_params[:expiration_date]
		@new_contest.start_date = contest_params[:start_date]
		if lecturer_signed_in?
			@new_contest.owner_id = current_lecturer.id
		elsif teaching_assistant_signed_in?
			@new_contest.owner_id = current_teaching_assistant.id
		end
		if @new_contest.save
			flash[:success_creation]= "Contest added."
			redirect_to :action => 'index'
		else 
			render :action=>'new'
		end
	end

end
