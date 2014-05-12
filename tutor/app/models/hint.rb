class Hint < ActiveRecord::Base

	#Validations
	validates :message, presence: true 
	validates :time, presence: true  

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true

	# [Problem Bank - Story 3.21]
	# Dublicate the hints of a specified problem
	# Parameters: none
	# Returns: the duplicated hints
	# Author: Ahmed Sharaf
	def duplicate 
		return dup 
	end
end
