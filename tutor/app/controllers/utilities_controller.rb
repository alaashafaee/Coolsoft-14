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

	# [Advanced Search - Story 1.23]
	# search for users and courses and topics
	# Parameters: search options
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def advanced_search
		if params[:lecturers].present?
			@lecturers  = Lecturer.search(params)
		end
		if params[:students].present?
			@students  = Student.search(params)
		end
		if params[:teaching_assistants].present?
			@teaching_assistants  = TeachingAssistant.search(params)
		end
		if params[:topics].present?
			@topics  = Topic.search(params)
		end
		if params[:courses].present?
			@courses  = Course.search(params)
		end
		if params[:posts].present?
			@posts  = Post.search(params)
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	# [Simple Search - Story 1.22]
	# auto complete search keyword for users and courses
	# Parameters: search
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def auto_complete
		@objects = Lecturer.simple_search(params[:q]).take(1)
		respond_to do |format|
			format.json {render :template => 'utilities/auto_complete',
				:formats => [], :handlers => [:json_builder], :layout=>false}
		end
	end

end
