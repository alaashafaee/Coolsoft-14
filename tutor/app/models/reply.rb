class Reply < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
	belongs_to :post
	 
	#Methods



end
