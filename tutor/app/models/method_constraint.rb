class MethodConstraint < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
	
	has_many :method_parameter, dependent: :destroy

	#Scoops
	
	#Methods

end
