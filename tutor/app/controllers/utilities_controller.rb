class UtilitiesController < ApplicationController
	
	# [Simple Search - Story 1.22]
	# search for users and courses
	# Parameters: search
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def simple_search
		@lecturers = Lecturer.simple_search(params[:search])
		@students = Student.simple_search(params[:search])
		@teaching_assisstants = TeachingAssistant.simple_search(params[:search])
		@courses = Course.simple_search(params[:search])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def advanced_search
		puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

	end
end
