class UtilitiesController < ApplicationController
	
	# [Simple Search - Story 1.22]
	# search for users and courses
	# Parameters: search
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def simple_search
		@lecturers = Lecturer.search(params[:search])
		puts @lecturers.present?
		@students = Student.search(params[:search])
		puts "______________________________________"
		puts @students.inspect
		@teaching_assisstants = TeachingAssistant.search(params[:search])
		puts @teaching_assisstants.present?
		puts ">>>>>>>>>>>>>>>>>>>>>>>>>>"
		@courses = Course.search(params[:search])
		puts @courses.inspect
		puts "_______________________________"
		respond_to do |format|
			format.html
		end
	end
end
