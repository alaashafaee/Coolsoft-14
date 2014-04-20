class StudentController < ApplicationController
	def show
		@student = Student.find(params[:id])
	end
	def new
	end
end