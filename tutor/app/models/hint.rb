class Hint < ActiveRecord::Base
	
	#Validations
	validates :message, presence: true 
	validates :time, presence: true  
	validates :time, numericality: {only_integer: true, greater_than_or_equal_to: 0,
											message: 
												"must be an integer & greater than or equal to 0"}
	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
	
	#Scoops
	
	#Methods

end
