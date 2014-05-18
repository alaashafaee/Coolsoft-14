class AssignmentTestcasesController < ApplicationController

	# [Create Assignment - Story 4.27]
	# To create a new testcase and save problem and assignment id.
	# Parameters:
	#	params[:cassignment_id]: id of the problem.
	# Returns: none 
	# Author: Nadine Adel
	def new
		@problem = AssignmentProblem.find_by_id(params[:assignment_id])
		@test_case = TestCase.new
		session[:assignment_problem_id] = params[:assignment_id]
		session[:problem_assignment_id] = @problem.assignment_id
	end

	# [Create Assignment - Story 4.27]
	# To create a new testcase related to acertain problem.
	# Parameters:
	#	new_test_case_params[]: parameters needed to save new test case.
	# Returns: 
	#	A message if the test case is saved or not 
	# Author: Nadine Adel
	def create
		@problem = AssignmentProblem.find_by_id(new_test_case_params[:assignment_problem_id])
		@test_case = TestCase.new(new_test_case_params)
		@test_case.input = new_test_case_params[:input]
		@test_case.output = new_test_case_params[:output]
		@test_case.assignment_problem_id = new_test_case_params[:assignment_problem_id]
		if lecturer_signed_in?
			@test_case.owner_id = current_lecturer.id
			@test_case.owner_type = "lecturer"
			@test_case.assignment_problem_id = session[:assignment_problem_id]
		elsif teaching_assistant_signed_in?
			@test_case.owner_id = current_teaching_assistant.id
			@test_case.owner_type = "teaching assistant"
			@test_case.assignment_problem_id = session[:assignment_problem_id]
		end
		if @test_case.save
			flash[:notice] = "Your test case is now added"
			redirect_to :controller => 'assignment_problems', :action => 'new',
			:id => session[:problem_assignment_id]
		else
			render :action=>'new', :assignment_id => @test_case.assignment_problem_id
		end
	end

	# [Create Assignment - Story 4.27]
	# To get from the new_test_case form the values needed to save new test case.
	# Parameters: none
	# Returns: 
	#	input: input of the test case.
	#	output: output of the testcase.
	#	assignment_problem_id: problem id to which the test case is related.
	# Author: Nadine Adel
	private
	def new_test_case_params
		params.require(:new_test_case).permit(:input, :output, :assignment_problem_id)
	end
	
end