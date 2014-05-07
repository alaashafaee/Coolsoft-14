class Hint < ActiveRecord::Base

	#Validations
	validates :message, presence: true 
	validates :time, presence: true  

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
end
