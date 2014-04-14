class TestCase < ActiveRecord::Base
	#Validations
	validates :output ,:presence => true 
	validates :output, :length => { :minimum => 1 }
	#Relations
	belongs_to :model_answer
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id
	belongs_to :problem
	#Scoops
	#Methods
end