class TestCase < ActiveRecord::Base
	#Validations
	validates :output ,:presence => true 
	validates :output, :length => { :minimum => 1 }
	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problem
	#Scoops
	#Methods
end
