class Hint < ActiveRecord::Base

	#Validations
	validates :message, presence: true 
	validates :submission_counter, presence: true, numericality: {
		only_integer: true, greater_than_or_equal_to: 0, message: "is not valid"}

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true
end
