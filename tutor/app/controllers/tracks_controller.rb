class TracksController < ApplicationController

	# [Integrating_Akram_Device - Story 4.1]
	# Shows a list of problems for the track with id :id
	# Parameters: 
	#   id: The id of the Track
	# Returns: Page with list of the problems
	# Author: Mussab ElDash
	def index
		@tracks= Track.all
	end

	def show
		id = params[:id]
		@track = Track.find_by_id(id)
		if @track
			@topic = @track.topic
			@course = @topic.course
			@problems = @track.problems
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		else
			render ('public/404')
		end
	end

	# [Create Track - Story 4.1]
	# render a json file with a set of problems of the track with id :id
	# Parameters: 
	#   id: The id of the Track
	# Returns: The list of the requested problems in json file
	# Author: Mussab ElDash
	def getProblems
		id = params[:id]
		track = Track.find(id)
		problems = track.problems
		render json: problems
	end

	# [Create Track - Story 4.1]
	# creates a new track with the passed parameters
	# if the parameters is valid a flash that it was save will show
	# and if not not a flash will show that there are fields missing
	# Parameters: 
	#   topic_id: The id of the topic to connect the track to
	#   title: The title of the track to be created
	#   difficulty: The difficulty of the track to be created
	# Returns: The same page that wants to create the Track
	# Author: Mussab ElDash
	def create
		t = Track.new(permit_create)
		if t.save
			flash[:success] = "Successfully created..."
			redirect_to :back
		else
			if params[:Track][:title] == ""
				flash[:error] = "The Title field is empty"
			elsif params[:Track][:difficulty] == ""
				flash[:error] = "The Difficulty field is empty"
			else
				flash[:error] = "An error has occured"
			end
			flash[:title] = params[:Track][:title]
			flash[:difficulty] = params[:Track][:difficulty]
			redirect_to :back
		end
	end

	# [Recommendatio to students - Story 5.7]
	# Gets students who can be recommended a problem of id :id
	# Parameters: none
	# Returns: json containing a Hash of classmates
	# Author: Mohab Ghanim
	def show_classmates
		problem = Problem.find_by_id(params[:id])
		track = problem.track
		topic = problem.track.topic
		course = problem.track.topic.course
		students_enrolled = course.students
		students_receiving_recommendation = Hash.new

		students_enrolled.each do |student|
			student_level = TrackProgression.get_progress(student.id,topic.id)
			if (student_level == track.difficulty)
				students_receiving_recommendation[student.id] = Hash.new
				students_receiving_recommendation[student.id]['student_name'] = student.name
				students_receiving_recommendation[student.id]['recommended_before'] = 'false'
				if (Recommendation.where(
					:problem_id => problem.id,
				 	:recommender_id => current_student.id,
				 	:student_id => student.id).present?)
						students_receiving_recommendation[student.id]['recommended_before'] = 'true'
				end
			end
		end
		render json: students_receiving_recommendation
	end

	# [Recommendation to students - Story 5.7]
	# Inserts a record in the recommendation table containing the id of the problem,
	#	the id of the students recommending the problem, the id of the student recieving
	#	the recommendation
	# Parameters: none
	# Returns: none
	# Author: Mohab Ghanim
	def insert_recommendation
		problem_id = params[:p_id]
		student_id = params[:s_id]
		recommender_id = params[:r_id]

		recommendation = Recommendation.new
		recommendation.problem_id = problem_id
		recommendation.student_id = student_id
		recommendation.recommender_id = recommender_id
		recommendation.save

		render :nothing => true
	end

	# [Create Track - Story 4.1]
	# permits the passed parameters
	# Parameters: 
	#   topic_id: The id of the topic to connect the track to
	#   title: The title of the track to be created
	#   difficulty: The difficulty of the track to be created
	# Returns: The permited params
	# Author: Mussab ElDash
	private
		def permit_create
			permit = params.require(:Track).permit(:topic_id, :title, :difficulty)
			topic = Topic.find_by_id(permit[:topic_id])
			if topic
				course = topic.course
			else
				return
			end
			can_edit = course.can_edit(current_lecturer)
			can_edit||= course.can_edit(current_teaching_assistant)
			if can_edit
				return permit
			end
		end
end