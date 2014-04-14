class Reply < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :post
	 
	#Scoops

	#Methods

end
