class LecturersController < ApplicationController
	def show
		@lecturer = Lecturer.find(params[:id])
	end
	def index
	end
end