class Compiler < ActiveRecord::Base

	# Methods
	
	# [Compiler: Compile - Story 3.4]
	# Writes the given code to a .java file with the name st[student_id]pr[problem_id]so[solution_id]
	#	using java_file_name/2. Then it compiles that file and returns the compiler's feedback.
	# Parameters:
	#	solution: The submitted solution.
	#	code: The code to be compiled.
	# Returns:
	#	The compiler's feedback
	# Author: Ahmed Moataz
	def self.compile(solution, code)
		folder_name = solution.folder_name
		%x[ #{'mkdir -p ' + Solution::SOLUTION_PATH + folder_name} ]
		file_name = Solution::SOLUTION_PATH + folder_name + '/' + solution.class_name + '.java'
		File.open(file_name, 'w') { |file| file.write(code) }
		return %x[ #{'javac -g ' + file_name + ' 2>&1'} ]
	end

	# [Compiler: Compile - Story 3.4]
	# Adds the class enclosure to the submitted code using append_class/4.
	#	Then compiles it using compile/4 and passes its result and feedback in a list.
	# Parameters:
	#	solution: The submitted solution.
	# Returns:
	#	A list. The first element is a boolean indicating the result of the compilation process.
	# 	The second element contains the compilation errors if any.
	#	The third element contains the compiled code.
	# Author: Ahmed Moataz
	def self.compiler_feedback(solution)
		#new_code = append_class(solution)
		feedback = compile(solution, solution.code)
		if feedback == ""
			return {success: true, errors: nil}
		else
			new_feedback = change_error_headers(solution, feedback)
			return {success: false, errors: new_feedback}
		end
	end

	# [Compiler: Compile - Story 3.4]
	#	Changes the error headers to CoolSoft.
	# Parameters:
	#	solution: The submitted solution.
	#	feedback: The compiler's feedback.
	# Returns:
	#	The compiler's feedback with the error headers changed to CoolSoft.
	# Author: Ahmed Moataz
	def self.change_error_headers(solution, feedback)
		header = Solution::SOLUTION_PATH + solution.folder_name + '/' + solution.class_name
		return feedback.gsub(header, solution.class_name).gsub(header, solution.class_name)
	end

end