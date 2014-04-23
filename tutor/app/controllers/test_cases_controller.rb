class TestCasesController < ApplicationController

	# [Add test case-story 4.8]
	# Shows all the test cases.
	# Parameters: None
	# Returns:List of all the test cases related to a certain problem.
	# Author: Lin
	def index
		@test_cases = TestCase.all
	end

	# [Add test case-story 4.8]
	# Display the form that is used to add a test case.
	# Parameters: None
	# Returns: None
	# Author: Lin
	def new
		@problem = Problem.find(params[:problem_id])
		session[:problem_id] = params[:problem_id]
		if(@test_case == nil)
		@test_case = TestCase.new()
	end
	end

	# [Add test case-story 4.8]
	# Saves the new test case into the database.(What the form the 'new' method will submit to)
	# Parameters: None
	# Returns: In case of success a flash notice will appear:"Post created successfully"
	#          In case of failure a flash notice will appear:"Can't add test case!"
	# Author: Lin
	def create
		@problem =Problem.find_by_id(session[:problem_id])
		if lecturer_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_lecturer.id
			@test_case.owner_type = "lecturer"
			@test_case.problem_id=session[:problem_id]
		elsif teaching_assistant_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_teaching_assistant.id
			@test_case.owner_type = "teaching assistant"
			@test_case.problem_id=session[:problem_id]
		end
		if @test_case.save
			@problem.test_cases << @test_case
			flash[:notice] = "Your test case is now added"
			redirect_to :controller => 'problems', :action => 'edit', :id => session[:problem_id]
		else
			
			render :action=>'new' , :problem_id => @test_case.problem_id
		end
	end

	# [Edit test case-story 4.9]
	# Edit test case 
	# Parameters: 
	#    @test_case:Test case to be edited.
	# Returns: None
	# Author: Nadine Adel
	def edit
		@test_case =TestCase.find(params[:id])		
		session[:problem_id] = params[:problem_id]
	end

	# [Edit test case-story 4.9]
	# Update test case in the database
	# Parameters: 
	#    @test_case:Test case to be updated.
	# Returns: flash message if the test case is updated or not
	# Author: Nadine Adel
	def update
		@test_case = TestCase.find(params[:id])
		if @test_case.update_attributes(post_params)
			flash[:notice] = "Your Testcase is now updated"
			redirect_to :controller => 'problems', :action => 'edit', :id => @test_case.problem_id
		else
			render :action=>'edit' , :problem_id => @test_case.problem_id
		end
	end

	# [Add test case-story 4.8]
	# private method. Controls the test case parameters that can be accessed.
	# Parameters: None
	# Returns: None
	# Author: Lin
	private
	def post_params
		params.require(:test_case).permit(:input, :output, :problem_id)
	end
end
