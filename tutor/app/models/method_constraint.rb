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
	# Returns: the duplicated Method constraints
	# Author: Ahmed Sharaf
	def duplicate 
		@mc = dup 
		method_parameters.each do |m|
			@mc.method_parameters << m.duplicate
		end
		return @mc
	end
end
