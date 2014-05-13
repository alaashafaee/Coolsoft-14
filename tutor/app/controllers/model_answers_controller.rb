class ModelAnswersController < ApplicationController

	# [Add answer story 4.6]
	# It creates the new answer.
	# Parameters:
	#	@problem: To fetch the problem to which the answer is added.
	#	@answer: The new answer the user enters.
	#	@answers: All the previous answers that had been entered before.
	# Returns: none
	# Author: Nadine Adel
	def new
		@problem = Problem.find(params[:problem_id])
		session[:problem_id] = params[:problem_id]
		if(@new_answer == nil)
			@new_answer = ModelAnswer.new
		end
	end

	# [Add answer story 4.6]
	# The new answer is saved and check that the user is a lecturer or TA.
	# Parameters:
	#	@new_answer: Answer provided by the user.
	#	@problems: The problem to which the answer is linked.
	# Returns:
	#	A message if the answer is added and another message if answer was not added.
	# Author: Nadine Adel & Ahmed Osam
	def create
		@new_answer = ModelAnswer.new
		@new_answer.title = model_answer_params_add[:title]
		@new_answer.answer = model_answer_params_add[:answer]
		@new_answer.problem_id = session[:problem_id] 
		@problems = Problem.find_by_id(session[:problem_id])
		if lecturer_signed_in?
			@new_answer.owner_id = current_lecturer.id
			@new_answer.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_answer.owner_id = current_teaching_assistant.id
			@new_answer.owner_type = "teaching assistant"
		end
		if @new_answer.save
			flash[:success_creation]= "Answer added."
			@problems.model_answers << @new_answer
			session[:problem_id] = @new_answer.problem_id
			session[:model_answer_id] = @new_answer.id
			redirect_to :controller => 'tips', :action => 'new', :model_answer_id => @new_answer.id,
			:track_id => session[:track_id]
		else
			render :action=>'new', :problem_id => model_answer_params_add[:problem_id]
		end
	end

	# [Remove Answer - Story 4.17]
	# This action takes the model answer id, and check if it is not the last model answer in the
	#	problem and remove it from the database and then redirects the user to the edit problem 
	#	page of the problem that had the answer with a "Model Answer successfully Deleted" message.
	# Parameters:
	#	params[:id]: The current model answer's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef
	def destroy
		@model_answer = ModelAnswer.find_by_id(params[:model_answer_id])
		@current = Problem.find_by_id(@model_answer.problem_id)
		if @current.model_answers.count == 1
			flash[:notice] = "Cannot delete problem's last model answer"
			redirect_to :back and return
		elsif @model_answer.destroy
			flash[:notice] = "Answer successfully Deleted"
			redirect_to(:controller => 'model_answers', :action => 'index',
			 :problem_id => @current.id, :track_id => session[:track_id])
		end	
	end

	# [Edit answer story 4.7]
	# Answer that has been created before is edited
	# Parameters:
	#	@answer: Answer that is being edited.
	#	@problem: The problem to which the answer is linked.
	#	@tips: Tips that are linked to the answer being edited.
	#	@tips_check: Used to check the type of Hint.
	#	@hints: Hints that are linked to the answer being edited.
	#	@hints_check: Used to check the type of Hint.
	# Returns:
	#	A message if the answer is edited and another message if answer was not edited.
	# Author: Nadine Adel
	def edit
		@answer = ModelAnswer.find(params[:model_answer_id])
		@problem = Problem.find(@answer.problem_id)
		@tips = @answer.hints
		@tips_check = @answer.hints
		@hints = @answer.hints
		@hints_check = @answer.hints
	end

	# [Edit answer story 4.7]
	# Answer is updated in the database. 
	# Parameters:
	#	@answer: Answer that is being updated.
	# Returns: none
	# Author: Nadine Adel
	def update
		@answer = ModelAnswer.find(params[:id])
		if model_answer_params[:title] != @answer.title ||
				model_answer_params[:answer] != @answer.answer
				begin
					if @answer.update_attributes(model_answer_params)
						respond_to do |format|
							format.js
							format.html {redirect_to :action => "edit", :format => :js, 
								:model_answer_id => @answer.id, :track_id => session[:track_id]}
						end
					else
						@answer = ModelAnswer.find_by_id(params[:model_answer_id])
						respond_to do |format|
							format.js
							format.html {redirect_to :action => "edit", :format => :js, 
								:model_answer_id => @answer.id, :track_id => session[:track_id]}
							
						end
					end
				rescue
					@answer = ModelAnswer.find_by_id(session[:model_answer_id])
					respond_to do |format|
						format.js
						format.html {redirect_to :action => "edit", :format => :js, 
							:model_answer_id => @answer.id, :track_id => session[:track_id]}
						
						end
				end
			end
		end

	# [Add answer story 4.6]
	# It shows answer that was entered before.
	# Parameters:
	#	@answer: Previous answer.
	# Returns: none
	# Author: Nadine Adel
	def show
		@answer = ModelAnswer.find(params[:problem_id])
	end

	# [Add answer story 4.6]
	# It shows all the answers that are saved in the database.
	# Parameters:
	#	@answers: Previous answers that are saved in the database.
	#	@problem: Problem to which the current answer is added.
	# Returns: none
	# Author: Nadine Adel
	def index
		session[:problem_id] = params[:problem_id]
		session[:track_id] = params[:track_id]
		@problem = Problem.find_by_id(params[:problem_id])
		@answers = @problem.model_answers
	end

	# [Add answer story 4.6]
	# It requires the attributes from the form that we are interested in.
	# Parameters: none
	# Returns: none
	# Author: Nadine Adel
	private
	def post_params
		params.require(:model_answer).permit(:title, :answer, :problem_id)
	end	
	def model_answer_params_add
		params.require(:model_answer).permit(:title, :answer, :problem_id)
	end
end