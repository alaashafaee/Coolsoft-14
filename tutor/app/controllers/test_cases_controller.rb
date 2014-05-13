class TestCasesController < ApplicationController

	# [Add test case-story 4.8]
	# Shows all the test cases.
	# Parameters: none
	# Returns:
	#	List of all the test cases related to a certain problem.
	# Author: Lin & Ahmed Osam
	def index
		session[:track_id] = params[:track_id]
		session[:problem_id] = params[:problem_id]
		@problem = Problem.find_by_id(session[:problem_id])
		@test_cases = @problem.test_cases
	end

	# [Add test case-story 4.8]
	# Display the form that is used to add a test case.
	# Parameters: none
	# Returns: none
	# Author: Lin & Ahmed Osam
	def new
		session[:track_id] = params[:track_id]
		session[:problem_id] = params[:problem_id]
		@problem = Problem.find(session[:problem_id])
		@test_case = TestCase.new
	end

	# [Add test case-story 4.8]
	# Saves the new test case into the database.(What the form the 'new' method will submit to)
	# Parameters: None
	# Returns:
	#	In case of success a flash notice will appear:"Post created successfully"
	#	In case of failure a flash notice will appear:"Can't add test case!"
	# Author: Lin
	def create
		@problem = Problem.find_by_id(session[:problem_id])
		@test_case = TestCase.new
		if lecturer_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_lecturer.id
			@test_case.owner_type = "lecturer"
			@test_case.problem_id = session[:problem_id]
		elsif teaching_assistant_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_teaching_assistant.id
			@test_case.owner_type = "teaching assistant"
			@test_case.problem_id = session[:problem_id]
		end
		if @test_case.save
			@problem.test_cases << @test_case
			flash[:notice] = "Your test case is now added"
			redirect_to :controller => 'model_answers', :action => 'new', 
			:problem_id => session[:problem_id], :track_id => session[:track_id]
		else
			render :action=>'new', :problem_id => @test_case.problem_id
		end
	end

	# [Edit test case-story 4.9]
	# Edit test case
	# Parameters:
	#	@test_case:Test case to be edited.
	# Returns: none
	# Author: Nadine Adel & Ahmed Osam
	def edit
		session[:problem_id] = params[:problem_id]
		session[:track_id] = params[:track_id]
		session[:test_case_id] = params[:test_case_id]
		@test_case =TestCase.find_by_id(session[:test_case_id])		
	end

	# [Edit test case-story 4.9]
	# Update test case in the database
	# Parameters:
	#	 @test_case:Test case to be updated.
	# Returns:
	#	Flash message if the test case is updated or not
	# Author: Nadine Adel
	def update
		@test_case = TestCase.find(params[:id])
		if @test_case.update_attributes(post_params)
			flash[:notice] = "Your Testcase is now updated"
			redirect_to :controller => 'problems', :action => 'edit', :id => @test_case.problem_id
		else
			render :action=>'edit', :problem_id => @test_case.problem_id
		end
	end

	# [Remove Test Case - Story 4.16]
	# This action takes the test case id, and check if it is not the last test case in the problem 
	#	and removes it from the database and then redirects the user to the edit problem page of 
	#	the problem that had the test case with a "Test case successfully Deleted" message.
	# Parameters:
	#	params[:id]: The current test case's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef
	def destroy
		@test_case = TestCase.find_by_id(params[:id])
		@current = Problem.find_by_id(@test_case.problem_id)
		if @current.test_cases.count == 1
			flash[:notice] = "Cannot delete problem's last test case"
			redirect_to :back and return
		elsif @test_case.destroy
			flash[:notice] = "Test case successfully Deleted"
			redirect_to(:controller => 'problems', :action => 'edit', :id => @current.id)
		end
	end

	# [Add test case-story 4.8]
	# Private method. Controls the test case parameters that can be accessed.
	# Parameters: none
	# Returns: none
	# Author: Lin
	private
	def post_params
		params.require(:test_case).permit(:input, :output, :problem_id)
	end
end
