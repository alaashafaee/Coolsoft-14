class ModelAnswersController < ApplicationController

	
#Nadine- saves all information in table ModelAnswer in variable @ answers
#saves a new record in table ModelAnswer in variable @answer
	
	def new

		@answers = ModelAnswer.all
		@answer = ModelAnswer.new
	end







#Nadine- creates in ModelAnswer a record with the parameters taken from the view and check if saved or not
#saved and notify the user
	def create
	 @answer = ModelAnswer.new(post_params)
	 if @answer.save
	 	flash[:notice] = "Your Answer is now added"
      redirect_to :back
      else
     flash[:notice] = "Your Answer can not be added "
     redirect_to :back
       
	end
	end



#Nadine- shows a single record in table ModelAnswer

	def show

		@answer = ModelAnswer.find(params[:problem_id])

	end
	

#Nadine- saves all record in ModelAnswer to loop on them in the view and show the records to the user
	def index
  	@answers = ModelAnswer.all
	end


#Nadine-it requires from the form in the view the attributes we are interested in
private
  def post_params
    params.require(:model_answer).permit(:answer)
  end


end
