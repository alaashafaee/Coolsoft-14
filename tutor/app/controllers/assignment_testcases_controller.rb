class AssignmentTestcasesController < ApplicationController
  def new
		@problem = AssignmentProblem.find_by_id(params[:assignment_id])
		session[:assignment_problem_id] = params[:assignment_id]
		
		
		session[:problem_assignment_id] = @problem.assignment_id

		
	end

	def create
		@problem = AssignmentProblem.find_by_id(new_test_case_params[:assignment_problem_id])
		@test_case = TestCase.new
		if lecturer_signed_in?
			@test_case = TestCase.new(new_test_case_params)
			@test_case.owner_id = current_lecturer.id
			@test_case.owner_type = "lecturer"
			@test_case.assignment_problem_id = session[:assignment_problem_id]
		elsif teaching_assistant_signed_in?
			@test_case = TestCase.new(new_test_case_params)
			@test_case.owner_id = current_teaching_assistant.id
			@test_case.owner_type = "teaching assistant"
			@test_case.assignment_problem_id = session[:assignment_problem_id]
		end
		if @test_case.save
			@problem.test_cases << @test_case
			flash[:notice] = "Your test case is now added"
			redirect_to :controller => 'assignment_problems', :action => 'new', 
			:id => session[:problem_assignment_id]
		else
			#render :action=>'new_test_case', :assignment_problem_id => @test_case.assignment_problem_id

		end

	end

  def show
  end

  def index
  end

  def edit
  end
  private
  def new_test_case_params
		params.require(:new_test_case).permit(:input, :output, :assignment_problem_id)
	end
end
