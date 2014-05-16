class TestCase < ActiveRecord::Base
	#Validations
	validates :input, :presence => true 
	validates :output, :presence => true 

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problem

	#Scoops

	#Methods

	# [Problem Bank - Story 3.21]
	# Dublicate all the test cases of the specified problem
	# Parameters: none
	# Returns: 
	#	the duplicated test cases
	# Author: Ahmed Sharaf
	def duplicate
		return dup
	end

end
