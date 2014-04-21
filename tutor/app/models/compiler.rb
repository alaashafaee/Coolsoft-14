class Compiler < ActiveRecord::Base
	
	#Validations
	
	#Relations
	
	#Scoops
	
	#Methods

	# Author: Ahmed Moataz
	def self.compile(student_id, problem_id, solution_id, code)
		#file name needs a third parameter to make it unique
		file_name = 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + solution_id.to_s + '.java'
		File.open(file_name, 'w') { |file| file.write(code) }
		return %x[ #{'javac -g ' + file_name +  ' 2>&1'} ]
	end

	# Author: Ahmed Moataz
	def self.compiler_feedback(student_id, problem_id, solution_id, code)
		new_code = change_class_name(student_id, problem_id, solution_id, code)
		feedback = compile(student_id,problem_id, solution_id, new_code)
		if feedback == ""
			return { success: true }
		else
			new_feedback = change_error_headers(student_id, problem_id, solution_id, feedback)
			return { success: false, errors: new_feedback }
		end					
	end	

	# Author: Ahmed Moataz
	def self.compile_test
		var = %x[ #{'javac -g ' + 'rubyJava2.java' +  ' 2>&1'} ]
		# return var + " \n " + "________" 
	end

	# Author: Ahmed Moataz
	def self.change_class_name(student_id, problem_id, solution_id, code)
		name = 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + solution_id.to_s
		if code.include? 'public' && 'class' && '{'
			return code.sub(code[0..code.index('{')], 'public class ' + name + ' {')
		else
			return code	
		end	
	end	

	# Author: Ahmed Moataz
	def self.change_error_headers(student_id, problem_id, solution_id, feedback)
		header = 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + solution_id.to_s
		return feedback.gsub(header, 'CoolSoft')
	end	
	
		
end