class UtilitiesController < ApplicationController
	
	# [Simple Search - Story 1.22]
	# search for users and courses
	# Parameters: search
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def simple_search
		@lecturers = Lecturer.search(params[:search])
		@students = Student.search(params[:search])
		@teaching_assisstants = TeachingAssistant.search(params[:search])
		@courses = Course.search(params[:search])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def advanced_search
	end
end
