class UtilitiesController < ApplicationController
  
	def simple_search
		@lecturers = Lecturer.search(params[:search])
		@students = Student.search(params[:search])
		@teaching_assisstants = TeachingAssistant.search(params[:search])
		
		respond_to do |format|
			format.html
		end
	end
end
