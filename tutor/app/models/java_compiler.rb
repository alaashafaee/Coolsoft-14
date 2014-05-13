class JavaCompiler < ActiveRecord::Base

	# Methods
	
	# [Compiler: Compile - Story 3.4]
	# Writes the given code to a .java file in a folder with the name
	#	st[student_id]pr[problem_id]so[solution_id] using folder_name/0.
	#	Then it compiles that file and returns the compiler's feedback.
	# Parameters:
	#	solution: The submitted solution.
	#	code: The code to be compiled.
	# Returns:
	#	The compiler's feedback.
	# Author: Ahmed Moataz
	def self.compile(solution, code)
		return solution.check_class_name if solution.check_class_name != ""
		folder_name = solution.folder_name
		file_path = solution.file_path
		%x[ #{'mkdir -p ' + Solution::SOLUTION_PATH + folder_name} ]
		File.open(file_path, 'w') { |file| file.write(code) }
		return %x[ #{'javac -g ' + file_path + ' 2>&1'} ]
	end

	# [Compiler: Compile - Story 3.4]
	# Compiles the solution's code using compile/2
	#	and returns its result and feedback in a list.
	# Parameters:
	#	solution: The submitted solution.
	# Returns:
	#	A list. The first element is a boolean indicating the result of the
	#		compilation process. The second element contains the compilation errors if any.
	# Author: Ahmed Moataz
	def self.compiler_feedback(solution)
		feedback = compile(solution, solution.code)
		if feedback == ""
			return {success: true, errors: nil}
		else
			new_feedback = change_error_headers(solution, feedback)
			return {success: false, errors: new_feedback}
		end
	end

	# [Compiler: Compile - Story 3.4]
	# Changes the error headers to the solution's class name.
	# Parameters:
	#	solution: The submitted solution.
	#	feedback: The compiler's feedback.
	# Returns:
	#	The compiler's feedback with the error headers changed to the solution's class name.
	# Author: Ahmed Moataz
	def self.change_error_headers(solution, feedback)
		header = Solution::SOLUTION_PATH + solution.folder_name + solution.class_name
		return feedback.gsub(header, solution.class_name).gsub(header, solution.class_name)
	end

end