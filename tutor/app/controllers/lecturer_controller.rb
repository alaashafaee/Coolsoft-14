class LecturerController < ApplicationController
	def show
		@lecturer = Lecturer.find(params[:id])
	end
	def new
	end
end