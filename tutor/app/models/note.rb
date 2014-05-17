class Note < ActiveRecord::Base

	#Validations
	validates_presence_of :content
	validates_presence_of :solution_id
	validates_presence_of :line
	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problems

	#Methods
	
end
