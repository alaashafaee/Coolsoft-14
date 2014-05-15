class ContestsController < ApplicationController
	
	def create
	end

	private
	def contest_params
		params.permit(:id, :student_id)
	end

end