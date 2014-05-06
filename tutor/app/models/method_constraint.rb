class MethodConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
	
	has_many :parameters, class_name:"MethodParameter", dependent: :destroy

	#Scoops
	
	#Methods

end
