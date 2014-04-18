class Compiler < ActiveRecord::Base
	
	#Validations
	
	#Relations
	
	#Scoops
	
	#Methods
	def compile(student_id, problem_id, code)
		#needs a third parameter to make it unique
		file_name = 's' + student_id.to_s + 'p' + problem_id.to_s + '.java'
		File.open(file_name, 'w') { |file| file.write(code) }
		return %x[ #{'javac ' + file_name +  ' 2>&1'} ]
	end
end
