class TestCase < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problem

	#Scoops

	#Methods

end
