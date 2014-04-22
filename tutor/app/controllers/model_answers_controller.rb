class ModelAnswersController < ApplicationController
	@@problemid = nil
	# [Add answer story 4.6]
	# It creates the new answer.
	# Parameters:
	#   @answer: the new answer the user enters.
	#   @answers: All the previous answers that had been entered before.
	#   Return : none
	# Author: Nadine Adel
	def new
		@problem = Problem.find(params[:problem_id])
		@@problemid =params[:problem_id]
		@answer =ModelAnswer.new
	end

	# [Add answer story 4.6]
	# The new answer is saved.
	# Parameters:
	#   @answer:answer provided by the user.
	# Returns: Returns a message if the answer is added and another message if answer was not added.
	# Author: Nadine Adel
	#<%= link_to "Save Model Answer"  , {:controller => 'problems',:action => 'edit',
    #:method => :get, :id => @problem.id },{class: 'btn btn-primary btn-xs', style: "text-decoration:none" }%>
	def create

		@problems =Problem.find_by_id(@@problemid)

		@answer = ModelAnswer.new(post_params)
		 

		if lecturer_signed_in?
			@answer = ModelAnswer.new(post_params)
			@answer.owner_id = current_lecturer.id
			@answer.owner_type = "lecturer"
			@answer.problem_id=@@problemid
			
		elsif teaching_assistant_signed_in?
			@answer = ModelAnswer.new(post_params)
			@answer.owner_id = current_teaching_assistant.id
			@answer.problem_id=@@problemid
			@answer.owner_type = "teaching assistant"
			
		end
		if @answer.save

			@problems.model_answers << @answer

			flash[:notice] = "Your Answer is now added"
			redirect_to :controller => 'problems', :action => 'edit', :id => @answer.problem_id
		else
			session[:error] = @answer.errors.full_messages
		
			redirect_to :back
			#redirect_to :controller => 'problems', :action => 'edit', :id => @answer.problem_id
		end
	end


	def edit
		@answer = ModelAnswer.find(params[:id])

		@problem = Problem.find(@answer.problem_id)

		@test_cases = @problem.test_cases
		@tips = @answer.hints
		@tips_check = @answer.hints
		@hints = @answer.hints
		@hints_check = @answer.hints
	end

	def update
		 @answer = ModelAnswer.find(params[:id])
      	if @answer.update_attributes(post_params)
      		flash[:notice] = "Your Answer is now updated"
         	redirect_to :controller => 'problems', :action => 'edit', :id => @@problemid
		else
         	session[:errorsupdate] = @answer.errors.full_messages
		
			redirect_to :back
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
		@problem =Problem.find_by_id(params[:id])
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

		params.require(:model_answer).permit(:title,:answer,:problem_id)



	end

	
end
