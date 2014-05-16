class VariableConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
		
	#Scoops
	
	#Methods

	# [Problem Bank - Story 3.21]
	# Dublicate the Variable Constraint of a specified problem
	# Parameters: none
	# Returns: 
	#	the duplicated Variable Constraint
	# Author: Ahmed Sharaf
	def duplicate
		return dup
	end

end
