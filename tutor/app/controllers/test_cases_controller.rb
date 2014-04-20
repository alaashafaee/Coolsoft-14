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
		@test_case = TestCase.new()
	end

	# [Add test case-story 4.8]
	# Saves the new test case into the database.(What the form the 'new' method will submit to)
	# Parameters: None
	# Returns: In case of success a flash notice will appear:"Post created successfully"
	#          In case of failure a flash notice will appear:"Can't add test case!"
	# Author: Lin
	def create
		if lecturer_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_lecturer.id
			@test_case.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@test_case = TestCase.new(post_params)
			@test_case.owner_id = current_teaching_assistant.id
			@test_case.owner_type = "teaching assistant"
		end
		if @test_case.save
			flash[:notice] = "Your test case is now added"
			redirect_to :controller => 'problems', :action => 'edit', :id => @test_case.problem_id
		else
			flash[:notice] = "Your test case cannot added"
			redirect_to :controller => 'problems', :action => 'edit', :id => @test_case.problem_id
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