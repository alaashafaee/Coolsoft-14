class ProblemsByTasController < ApplicationController
	#The Action takes as an input the paramaters of permitCreate action,
	#creates a new record to Problem Table and outputs a message to notify the user
	def create
		p = Problem.new(permitCreate)
  		if p.save
  			flash.keep[:notice] = "Problem is added"
  			redirect_to :back
		else 
			flash.keep[:notice] = "Problem are missing paramaters"	
			redirect_to :back
		end
	end
	#The Action passes the input of the form as paramaters for create action to use it
	def permitCreate
  	params.require(:Problem).permit(:title , :description) 
  	end
	#The Action saves all the records in Problem table in an instance variable 
	#for the rendered view (_all_problems.html.erb) to use it
	def create_page
		@problems = Problem.all
		@counter = 1
	end	
	#The Action takes as an input the id of the pressed problem and saves the corresponding problem
	#in an instance variable so that the view show.html.erb can use it
	def show
  		@problem = Problem.find_by_id(params[:id])
  		if @problem
  		else
  		render('public/404')	
  		end
  	end

end
