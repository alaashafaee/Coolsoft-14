class Compiler < ActiveRecord::Base
	
	#Validations
	
	#Relations
	
	#Scoops
	
	#Methods

	# Author: Ahmed Moataz
	def compile(student_id, problem_id, code)
		#file name needs a third parameter to make it unique
		file_name = 's' + student_id.to_s + 'p' + problem_id.to_s + '.java'
		File.open(file_name, 'w') { |file| file.write(code) }
		return %x[ #{'javac -g ' + file_name +  ' 2>&1'} ]
	end

	# Author: Ahmed Moataz
	def compiler_feedback(student_id, problem_id, code)
		feedback = compile(student_id,problem_id, code)
		if feeedback == ""
			return { success: true }
		else
			return { success: false, errors: feeedback }
		end					
	end	

	# Author: Ahmed Moataz
	def compile_test
		var = %x[ #{'javac -g ' + 'rubyJava2.java' +  ' 2>&1'} ]
		return var + " \n " + "________" 
	end

	
		
end