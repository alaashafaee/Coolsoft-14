class TestCase < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :problem
	belongs_to :owner, class_name: 'Stuff', foreign_key: :stuff_id
	
	#Scoops
	#Methods



end
