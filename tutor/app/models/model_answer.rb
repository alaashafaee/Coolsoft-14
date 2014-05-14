class ModelAnswer < ActiveRecord::Base

	#Validations
	validates :title, presence: true
	validates :answer, presence: true

	#Relations
	belongs_to :problem
	belongs_to :owner, polymorphic: true

	has_many :method_constraints, dependent: :destroy
	has_many :variable_constraints, dependent: :destroy
	has_many :hints, dependent: :destroy

	#Scoops

	#Methods

	# [Problem Bank - Story 3.21]
	# Dublicate all the Method Constraints and Variable Constraints of a specified problem
	# Parameters: none
	# Returns: 
	#	the duplicated model answers
	# Author: Ahmed Sharaf
	def duplicate 
		@ma = dup 
		method_constraints.each do |m|
			@ma.method_constraints << m.duplictae
		end
		variable_constraints.each do |c|
			@ma.variable_constraints << c.duplicate
		end
		return @ma
	end

end
