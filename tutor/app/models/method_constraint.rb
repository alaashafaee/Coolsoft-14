class MethodConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id

	#Scoops
	
	#Methods



end
