class UtilitiesController < ApplicationController

	# [Simple Search - Story 1.22]
	# search for users and courses
	# Parameters: search
	# Returns: A hashes with search results according to the keyword
	# Author: Ahmed Elassuty
	def simple_search
		@lecturers = Lecturer.simple_search(params[:search])
			.paginate(:page => params[:page], :per_page => 3)
		@students = Student.simple_search(params[:search])
			.paginate(:page => params[:page], :per_page => 3)
		@teaching_assisstants = TeachingAssistant.simple_search(params[:search])
			.paginate(:page => params[:page], :per_page => 3)
		@courses = Course.simple_search(params[:search])
			.paginate(:page => params[:page], :per_page => 3)
		@objects = @courses
		if @lecturers.count > @students.count
			if @lecturers.count > @teaching_assisstants.count
				if @lecturers.count > @courses.count
					@objects = @lecturers
				end
			else
				if @teaching_assisstants.count > @courses.count
					@objects = @teaching_assistants
				end
			end
		else
			if @students.count > @teaching_assisstants.count
				if @students.count > @courses.count
					@objects = @students
				end
			else
				if @teaching_assisstants.count > @courses.count
					@objects = @teaching_assisstants
				end
			end
		end
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
		objects = Lecturer.simple_search(params[:term]).take(2)
		auto_complete = []
		auto_complete = auto_complete.concat(objects.map(&:name)) unless objects.nil?
		objects = Student.simple_search(params[:term]).take(2)
		auto_complete = auto_complete.concat(objects.map(&:name)) unless objects.nil?
		objects = TeachingAssistant.simple_search(params[:term]).take(2)
		auto_complete = auto_complete.concat(objects.map(&:name)) unless objects.nil?
		objects = Course.simple_search(params[:term]).take(2)
		auto_complete = auto_complete.concat(objects.map(&:name)) unless objects.nil?
		render json: auto_complete
	end

end
