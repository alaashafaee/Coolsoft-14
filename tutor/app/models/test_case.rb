class TestCase < ActiveRecord::Base
	#Validations
    validates :input , :output , :presence => true 
    validates :input , :length => { :minimum => 1 }
	validates :output, :length => { :minimum => 1 }
	#Relations
	belongs_to :model_answer
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id
	belongs_to :problem
	#Scoops
	#Methods
end
