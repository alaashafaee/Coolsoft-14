class ContestsController < ApplicationController

	before_action :validate_timer
	
	private

		def validate_timer
			@contest = Contest.find(params[:id])
			@start = (@contest.start_date.to_s + " " + @contest.start_time.to_s).to_datetime
			@end = (@contest.end_date.to_s + " " + @contest.end_time.to_s).to_datetime
		end

end
