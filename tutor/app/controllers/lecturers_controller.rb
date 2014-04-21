class LecturersController < ApplicationController
	def index
	end
	def show
		@lecturer = Lecturer.find(params[:id])
	end
end