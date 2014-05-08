class SolutionsLayer

	def self.execute lang, code, student_id, problem_id, cases
		executer = get_executer lang
		compiler = get_compiler lang
		solution = get_solution code, student_id, problem_id
		compile_status = {}
		if compiler
			compile_status = compiler.compiler_feedback(solution)
			unless compile_status[:success]
				return {compiler_error: true, compiler_output: compile_status}
			end
		end
		return executer.execute(solution, cases)
	end

	def self.compile lang, code, student_id, problem_id
		compiler = get_compiler lang
		solution = get_solution code, student_id, problem_id
		if compiler
			feed_back = compiler.compiler_feedback solution
			if feed_back[:success]
				solution.status = 3
			else
				solution.status = 2
			end
			return feed_back
		else
			return
		end
	end

	def self.validate lang, code, student_id, problem_id, time
		solution = get_solution code, student_id, problem_id
		solution.time = time
		test_cases = solution.problem.test_cases
		return Solution.validate solution, test_cases
	end

	def self.debug lang, code, student_id, problem_id, cases
		solution = get_solution code, student_id, problem_id
		debugger = get_debugger lang
		compiler = get_compiler lang
		if debugger
			if compiler
				compile_status = compiler.compiler_feedback(solution)
				unless compile_status[:success]
					return {:success => false, data: compile_status}
				end
			end
			debugger.debug solution, cases
		else
			return
		end
	end

	# [Layer - Story X.3]
	# Creates a new solution for future use
	# Parameters:
	# 	Student_id: The id of the current signed in student
	# 	problem_id: The id of the problem being solved
	# 	code: The code to be debugged
	# Returns: A new Solution
	# Author: Mussab ElDash
	def self.get_solution code, student_id, problem_id
		solution = Solution.create({code: code, student_id: student_id,
				problem_id: problem_id})
		return solution
	end

	def self.get_executer lang
		lang = lang.capitalize
		executer = lang + "Executer"
		return eval executer
	end

	def self.get_compiler lang
		lang = lang.capitalize
		compiler_string = lang + "Compiler"
		begin
			compiler = eval compiler_string
		rescue Exception => e
			compiler = false
		end
		return compiler
	end

	def self.get_debugger lang
		lang = lang.capitalize
		debugger_string = lang + "Debugger"
		begin
			debugger = eval debugger_string
		rescue Exception => e
			debugger = false
		end
		return debugger
	end

end