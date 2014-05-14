class ContestsController < ApplicationController

 
	def show
		@contest = Contest.find(params[:id])
		@problems =  @contest.problems.all
	end	
end
