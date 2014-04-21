class UtilitiesController < ApplicationController
  
	def simple_search
		@lecturers = Lecturer.where("name LIKE ? or email LIKE ?", "%#{params[:search]}%" , "%#{params[:search]}%")
		@students = Student.where("name LIKE ? or email LIKE ?", "%#{params[:search]}%" , "%#{params[:search]}%")
		@teaching_assisstants = TeachingAssistant.where("name LIKE ? or email LIKE ?", "%#{params[:search]}%" , "%#{params[:search]}%")
		
		respond_to do |format|
			format.html
		end
	end
end
