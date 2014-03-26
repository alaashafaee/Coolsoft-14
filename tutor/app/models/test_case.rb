class TestCase < ActiveRecord::Base
	
	#Validations

	#Relations
<<<<<<< HEAD
	belongs_to :model_answer

	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id

=======
	belongs_to :problem
	belongs_to :owner, class_name: 'Stuff', foreign_key: :stuff_id
>>>>>>> 1054863c9e8bdc7de2d28018e546f03938c63d46
	
	#Scoops
	#Methods



end
