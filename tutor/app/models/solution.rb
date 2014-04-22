class Solution < ActiveRecord::Base
	
	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem
	
	#Scoops

	#Methods
	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the file name associated with this solution code.
	# Parameters:
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's java file name
	# Author: Rami Khalil
	def file_name
		return 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + id.to_s
	end

	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the java file name associated with this solution code.
	# Parameters:
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's java file name
	# Author: Rami Khalil
	def java_file_name(prepend_path = false, append_extension = false)
		jfile_name = file_name
		jfile_name += ".java" if append_extension
		jfile_name = JAVA_PATH + jfile_name if prepend_path
		return jfile_name
	end

	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the class file name associated with this solution code.
	# Parameters:
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's class file name
	# Author: Rami Khalil
	def class_file_name(prepend_path = false, append_extension = false)
		jfile_name = file_name
		jfile_name += ".class" if append_extension
		jfile_name = CLASS_PATH + jfile_name if prepend_path
		return jfile_name
	end

	# [Compiler: Test - Story 3.15]
	# Returns the class path.
	# Parameters:
	# 	none
	# Returns: 
	# 	The class path
	# Author: Ahmed Akram
	def self.get_class_path
		CLASS_PATH
	end

	# [Compiler: Test - Story 3.15]
	# Returns the java path.
	# Parameters:
	# 	none
	# Returns: 
	# 	The java path
	# Author: Ahmed Akram
	def self.get_java_path
		JAVA_PATH
	end

	#Constants
	STATUS_SUBMITTED 	= 	0
	STATUS_ACCEPTED		=	1

	JAVA_PATH	=	'students_solutions/Java/'
	CLASS_PATH	=	'students_solutions/Class/'
end
