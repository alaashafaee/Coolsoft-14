class StudentsController < ApplicationController
	def index
	end
	def show
		@student = Student.find(params[:id])
	end
end