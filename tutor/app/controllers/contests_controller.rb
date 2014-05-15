class ContestsController < ApplicationController

	before_action :validate_timer
	
	private

		def validate_timer
			@contest = Contest.find(params[:id])
			contest_start = (@contest.start_date.to_s + " " + @contest.start_time.to_s).to_datetime
			contest_end = (@contest.end_date.to_s + " " + @contest.end_time.to_s).to_datetime
			current = DateTime.now
			if current < contest_start
				@timer = contest_start.to_s
				@message = "Contest starts in"
				@del = false
			elsif current <= contest_end
				@timer = contest_end.to_s
				@message = "Contest ends in"
				@del = false
			else
				@timer = DateTime.now
				@message = "Contest has finished!"
				@del = true
			end	
		end

end
