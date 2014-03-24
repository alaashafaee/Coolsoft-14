class VariableConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, class_name: 'Stuff', foreign_key: :stuff_id
	
	#Scoops
	
	#Methods


end
