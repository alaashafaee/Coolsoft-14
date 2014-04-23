class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	#	and outputs 2 flash messages for success and failure scenarios
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		if params[:commit] == 'Submit'
			compile_solution
			if flash[:compiler_fail] || flash[:alert]
				redirect_to :back and return
			end
			submit_no_ajax
		elsif params[:commit] == 'Compile'
			compile_solution
			redirect_to :back and return
		elsif params[:commit] == 'Run Test Case'
			compile_solution
			if flash[:compiler_fail] || flash[:alert]
				redirect_to :back and return
			end
			execute
		end
	end

	# [Compiler: Test - Story 3.15]
	# This Action runs the execute method from the Executer model
	# Parameters:
	#	@solution: The submitted solution
	# Returns:
	# 	A flash message containing the appropriate reply
	# Author: Ahmed Akram
	def execute
		file_name = @solution.file_name
		if Executer.execute(file_name, input[:input], solution_params[:problem_id])
			output = Executer.get_output()
			flash[:msg] = output
		else
			output = Executer.get_runtime_error(file_name, 'CoolSoft')
			flash[:msg] = output[:error]
			flash[:exp] = output[:explanation]
		end
		redirect_to :back
	end

	# [Compiler: Compile - Story 3.4]
	# Creates a soution for the current problem in the database and compiles it.
	#	Then it places the previous code and the compilation results and feedback in the flash hash.
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: Ahmed Moataz
	def compile_solution
		@solution = Solution.new(solution_params)
		@solution.student_id = current_student.id
		@solution.length = @solution.code.length
		@solution.status = 0
		if @solution.save
			compiler_feedback = Compiler.compiler_feedback(@solution)
			if compiler_feedback[:success]
				@solution.status = 3
				flash[:compiler_success] = "Compilation Succeeded!"
				flash[:previous_code] = compiler_feedback[:previous_code]
			else
				@solution.status = 2
				flash[:compiler_fail] = "Compilation Failed!"
				flash[:compiler_feedback] = compiler_feedback[:errors]
				flash[:previous_code] = compiler_feedback[:previous_code]
			end
			@solution.save
		else
			flash[:alert] = "You did not write any code!"
		end
	end

	def submit_no_ajax
			#testcases = @solution.problem.test_cases
			file = @solution.file_name
			#s_id = solution_params[:problem_id].to_i + 1
			response_message = Solution.validate(file, solution_params[:problem_id])
			flash[:compiler_success_2] = response_message[:success]
			flash[:msg_2] = response_message[:runtime_error]
			flash[:exp_2] = response_message[:runtime_error_exp]
			flash[:compiler_fail_2] = response_message[:logic_error]
			@solution.status = response_message[:status]
			@solution.save
			redirect_to :back
	end

	private
		# [Code Editor: Write Code - Story 3.3]
		# Permits the id of the problem, code from the form_for
		# Parameters:
		# 	code: The written code for the problem
		# 	problem_id: Hidden field for problem id
		# Returns:
		# 	none
		# Author: MOHAMEDSAEED
		def solution_params
			params.require(:solution).permit(:code, :problem_id)
		end

		# [Compiler: Test - Story 3.15]
		# Permits the input
		# Parameters:
		#	none
		# Returns:
		# 	params[:input]: The test case entered by the solver
		# Author: Ahmed Akram
		def input
			params.require(:solution).permit(:input)
		end
end