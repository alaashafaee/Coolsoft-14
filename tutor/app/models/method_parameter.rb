class MethodParameter < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :method_constarint

	belongs_to :owner, polymorphic: true
	
	#Scoops
	
	#Methods

	# [Problem Bank - Story 3.21]
	# Dublicate the Method parameters of a specified problem
	# Parameters: none
	# Returns: 
	#	the duplicated Method parameters
	# Author: Ahmed Sharaf
	def duplicate
		return dup
	end

end
