class ContestsController < ApplicationController

	def index
	end


	def show
		@contest = Contest.find_by_id(params[:id])
	end
	
end
