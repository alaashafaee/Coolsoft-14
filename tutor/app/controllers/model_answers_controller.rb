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
		@answer = ModelAnswer.new(post_params)
		if params[:first_button]
		if @answer.save 
			flash[:notice] = "Your Answer is now added"
			redirect_to :back
		else
			flash[:notice] = "Your Answer can not be added "
			redirect_to :back
		end
		else
			render "edit"
		end
	


	end

# [Add answer story 4.6]
# It shows answer that was entered before. 
# Parameters: 
#   @answer:previous answer.
#   Return : none
# Author: Nadine Adel
	def edit
		@answer = ModelAnswer.find(params[:id])
		#@answer_modified.update(answer::modifiedanswer)
		#@answer_modified.content = post_params1(:answer)
		#@answers = ModelAnswer.find(params[:id]) 
	#	@answers.update(answer:'yarab')

		#@answer = ModelAnswer.where(answer_ID: params[:id])

	end
	def update
		 @answer = ModelAnswer.find(params[:id])
      if @answer.update_attributes(post_params)
         redirect_to :action => 'new', :id => @answer_modified
      else
         
        flash[:notice] = "Your Answer is now added"
      end
	#		<% answers = ModelAnswer.find(params[:id]) %>
	#	<% answers.update(answer:'oppaa') %>
	#	<% answers.save %
	#	if params[:second_button]
		
	#else
	#	flash[:notice] = "Your Answer can notddd be added "
	#	end

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
		params.require(:model_answer).permit(:answer)


	end
	private
	def post_params1
		params.require(:modified_answer).permit(:modifiedanswer)

	end
	end