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
	# Author: Nadine Adel
	def create
		@new_answer = ModelAnswer.new
		@new_answer.title = post_params[:title]
		@new_answer.answer = post_params[:answer]
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
			redirect_to :controller => 'model_answers', :action => 'edit', :id => @new_answer.id
		else
			render :action=>'new', :problem_id => post_params[:problem_id]
		end
	end

	# [Remove Answer - Story 4.17]
	# This action takes the model answer id, and check if it is not last model answer in the problem 
	#	and remove it from the database and then redirects the user to the edit problem page of 
	#	the problem that had the answerwith a "Model Answer successfully Deleted" message.
	# Parameters:
	#	params[:id]: The current model answer's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef
	def destroy
		@model_answer = ModelAnswer.find_by_id(params[:id])
		@current = Problem.find_by_id(@model_answer.problem_id)
		if @current.model_answers.count == 1
			flash[:notice] = "Cannot delete problem's last model answer"
			redirect_to :back and return
		elsif @model_answer.destroy
			flash[:notice] = "Answer successfully Deleted"
			redirect_to(:controller => 'problems', :action => 'edit', :id => @current.id)
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
		@answer = ModelAnswer.find(params[:id])
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
		if @answer.update_attributes(post_params)
			flash[:notice] = "Your Answer is now updated"
  			redirect_to :controller => 'problems', :action => 'edit',
  				:id => session[:problem_id]
		else
		render :action=>'edit', :problem_id => @answer.problem_id
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
		@problem = Problem.find_by_id(params[:id])
		@answers = ModelAnswer.all
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
end