class ProblemBankController < ApplicationController
	def show
		puts params
		# @track_id = params[:id]
		puts = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		# puts @track_id
		@problems = Problem.all
	end
end
