class MethodConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
	
	has_many :parameters, class_name:"MethodParameter", dependent: :destroy

	#Scoops
	
	#Methods

	# [Problem Bank - Story 3.21]
	# Dublicate the Method constraints of a specified problem
	# Parameters: none
	# Returns: 
	#	the duplicated Method constraints
	# Author: Ahmed Sharaf
	def duplicate
		@duplicated_method_constraint = dup
		method_parameters.each do |m_parameter|
			@duplicated_method_constraint.method_parameters << m_parameter.duplicate
		end
		return @duplicated_method_constraint
	end

end
