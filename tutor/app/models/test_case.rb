class TestCase < ActiveRecord::Base
	#Validations
	validates :input, :presence => true 
	validates :output, :presence => true 
	validates_uniqueness_of :input, :scope => :output

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problem

	#Scoops

	#Methods

end