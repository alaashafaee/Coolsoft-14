class VariableConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
		
	#Scoops
	
	#Methods

end
