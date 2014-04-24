class TestCase < ActiveRecord::Base
	#Validations
	validates :input, :presence => true 
	validates :output, :presence => true 

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problem

	#Scoops

	#Methods

end
