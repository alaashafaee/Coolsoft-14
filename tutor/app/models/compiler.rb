class Compiler < ActiveRecord::Base

	# [Compiler: Compile - Story 3.4]
	# Writes the given code to a .java file with the name st[student_id]pr[problem_id]so[solution_id].
	#	Then it compiles that file and returns the compiler's feedback.
	# Parameters:
	#	student_id: The ID of the current student.
	#	problem_id: The ID of the current problem.
	#	solution_id: The ID of the submitted solution.
	#	code: The code to be compiled.
	# Returns:
	#	The compiler's feedback.
	# Author: Ahmed Moataz
	def self.compile(student_id, problem_id, solution_id, code)
		java_path = 'students_solutions/Java/'
		%x[ #{'mkdir -p ' + java_path} ]
		file_name = java_path + 'st' + student_id.to_s + 'pr' +
			problem_id.to_s + 'so' + solution_id.to_s + '.java'
		File.open(file_name, 'w') { |file| file.write(code) }
		class_path = 'students_solutions/Class'
		%x[ #{'mkdir -p ' + class_path} ]
		return %x[ #{'javac -g -d ' + class_path + ' ' + file_name + ' 2>&1'} ]
	end

	# [Compiler: Compile - Story 3.4]
	# Adds the class enclosure to the submitted code using append_class/4.
	#	Then compiles it using compile/4 and passes its result and feedback in a list.
	# Parameters:
	#	student_id: The ID of the current student.
	#	problem_id: The ID of the current problem.
	#	solution_id: The ID of the submitted solution.
	#	code: The submitted code.
	# Returns:
	#	A list. The first element is a boolean indicating the result of the compilation process.
	# 	The second element contains the compilation errors if any.
	# Author: Ahmed Moataz
	def self.compiler_feedback(student_id, problem_id, solution_id, code)
		new_code = append_class(student_id, problem_id, solution_id, code)
		feedback = compile(student_id, problem_id, solution_id, new_code)
		if feedback == ""
			return { success: true, errors: nil }
		else
			new_feedback = change_error_headers(student_id, problem_id, solution_id, feedback)
			return { success: false, errors: new_feedback }
		end
	end

	# [Compiler: Compile - Story 3.4]
	#	Appends the class enclosure to the to submitted code.
	# Parameters:
	#	student_id: The ID of the current student.
	#	problem_id: The ID of the current problrm.
	#	solution_id: The ID of the submitted solution.
	#	code: The submitted code.
	# Returns:
	#	The code with the class enclosure.
	# Author: Ahmed Moataz
	def self.append_class(student_id, problem_id, solution_id, code)
		name = 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + solution_id.to_s
		return 'public class ' + name + " {\n" + code + "\n}"
	end

	# [Compiler: Compile - Story 3.4]
	#	Changes the error headers to CoolSoft.
	# Parameters:
	#	student_id: The ID of the current student.
	#	problem_id: The ID of the current problrm.
	#	solution_id: The ID of the submitted solution.
	#	feedback: The compiler's feedback.
	# Returns:
	#	The compiler's feedback with the error headers changed to CoolSoft.
	# Author: Ahmed Moataz
	def self.change_error_headers(student_id, problem_id, solution_id, feedback)
		header = 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + solution_id.to_s
		return feedback.gsub('students_solutions/Java/' + header, 'CoolSoft')
	end

end