class Solution < ActiveRecord::Base
	
	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem
	
	#Scoops

	#Methods
	# [Compiler: Compile - Story 3.4, Debugger: Debug - Story 3.6]
	# Returns the java file name associatd with this solution code.
	# Parameters:
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's java file name
	# Author: Rami Khalil
	def java_file_name append_extension=false
		file_name = JAVA_PATH + 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + id.to_s
		file_name += ".java" if append_extension
		return file_name
	end

	# [Compiler: Compile - Story 3.4, Debugger: Debug - Story 3.6]
	# Returns the class file name associatd with this solution code.
	# Parameters:
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's class file name
	# Author: Rami Khalil
	def class_file_name append_extension=false
		file_name = CLASS_PATH + 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + id.to_s
		file_name += ".class" if append_extension
		return file_name
	end

	#Constants
	STATUS_SUBMITTED 	= 	0
	STATUS_ACCEPTED		=	1

	JAVA_PATH	=	'students_solutions/Java/'
	CLASS_PATH	=	'students_solutions/Class'
end
