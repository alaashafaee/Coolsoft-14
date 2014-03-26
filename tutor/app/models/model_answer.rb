class ModelAnswer < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :problem
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id

	has_many :test_cases, dependent: :destroy
	has_many :method_constraints, dependent: :destroy
	has_many :method_parameters, dependent: :destroy
	has_many :variable_constraints, dependent: :destroy
	has_many :hints, dependent: :destroy
	
	#Scoops
	
	#Methods



end
