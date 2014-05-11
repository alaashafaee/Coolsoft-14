class ContestsController < ApplicationController

	def new
		if student_signed_in?
			render ('public/404')
		end
		if(@new_contest == nil)
			@new_contest = Contest.new
		end
		if lecturer_signed_in?
			@owner_courses = current_lecturer.courses
			@owner_courses = @owner_courses.map {|x| x.name}
		elsif teaching_assistant_signed_in?
			@owner_courses = current_teaching_assistant.courses
			@owner_courses = @owner_courses.map {|x| x.name}
		end
	end

	def create
		@new_contest  = Contest.new
		@new_contest.title = contest_params[:title]
		@new_contest.course_id = Course.find_by_name(contest_params[:course]).id
		@new_contest.description = contest_params[:description]
		@new_contest.start_date = Date.new(contest_params["start_date(1i)"].to_i,
			contest_params["start_date(2i)"].to_i, contest_params["start_date(3i)"].to_i)
		@new_contest.start_time = Time.new(contest_params["start_date(1i)"].to_i,
			contest_params["start_date(2i)"].to_i, contest_params["start_date(3i)"].to_i,
			contest_params["start_time(4i)"].to_i, contest_params["start_time(5i)"].to_i)
		@new_contest.end_date = Date.new(contest_params["end_date(1i)"].to_i,
			contest_params["end_date(2i)"].to_i, contest_params["end_date(3i)"].to_i)
		@new_contest.end_time = Time.new(contest_params["end_date(1i)"].to_i,
			contest_params["end_date(2i)"].to_i, contest_params["end_date(3i)"].to_i,
			contest_params["end_time(4i)"].to_i, contest_params["end_time(5i)"].to_i)
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

	private
		def contest_params 
			params.require(:contest).permit(:title, :description, :course, :start_date, :start_time,
				:end_date, :end_time)
		end

end
