class ModelAnswersController < ApplicationController
	# [Add answer story 4.6]
	# It creates the new answer.
	# Parameters:
	#   @answer: the new answer the user enters.
	#   @answers: All the previous answers that had been entered before.
	#   Return : none
	# Author: Nadine Adel
	def new
		@answers = ModelAnswer.all
		@answer = ModelAnswer.new
	end

	# [Add answer story 4.6]
	# The new answer is saved.
	# Parameters:
	#   @answer:answer provided by the user.
	# Returns: Returns a message if the answer is added and another message if answer was not added.
	# Author: Nadine Adel
	def create
		if lecturer_signed_in?
			@answer = ModelAnswer.new(post_params)
			@answer.owner_id = current_lecturer.id
			@answer.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@answer = ModelAnswer.new(post_params)
			@answer.owner_id = current_teaching_assistant.id
			@answer.owner_type = "teaching assistant"
		end
		if @answer.save
			flash[:notice] = "Your Answer is now added"
			redirect_to :controller => 'problems', :action => 'edit', :id => @answer.problem_id
		else
			flash[:notice] = "Your Answer can not be added"
			redirect_to :controller => 'problems', :action => 'edit', :id => @answer.problem_id
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
		if(@current.model_answers.count == 1)
			flash[:notice] = "Cannot delete problem's last model answer"
			redirect_to :back and return
		elsif @model_answer.destroy
			flash[:notice] = "Answer successfully Deleted"
			redirect_to(:controller => 'problems' , :action => 'edit' ,:id => @current.id)
		end
	end

	# [Add answer story 4.6]
	# It shows answer that was entered before.
	# Parameters:
	#   @answer:previous answer.
	#   Return : none
	# Author: Nadine Adel
	def show
		@answer = ModelAnswer.find(params[:problem_id])
	end

	# [Add answer story 4.6]
	# It shows all the answers that are saved in the database.
	# Parameters:
	#   @answers:previous answer that are saved in the database.
	#   Return : none
	# Author: Nadine Adel
	def index
		@answers = ModelAnswer.all
	end

	# [Add answer story 4.6]
	# It requires the attributes from the form that we are interested in.
	# Parameters:
	#   @answer:the answer that the user wants to add.
	#   Return : none
	# Author: Nadine Adel
	private
	def post_params
		params.require(:model_answer).permit(:answer, :problem_id)
	end
end