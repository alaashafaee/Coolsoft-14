class Hint < ActiveRecord::Base

	#Validations
	validates :message, presence: true
	validates :time, presence: true,
		numericality: {only_integer: true, greater_than_or_equal_to: 0,
		message: "must be an integer & greater than or equal to 0"}
	validates_uniqueness_of :message, :scope => :model_answer_id 
	validates :submission_counter, presence: true,
		numericality: {only_integer: true, greater_than_or_equal_to: 0,
		message: "must be an integer & greater than or equal to 0"}

	#Relations
	belongs_to :model_answer
	belongs_to :owner, polymorphic: true

	#Methods
	def self.get_hints model_answer_id
		Hint.find(:all, :conditions => ["category = ? AND model_answer_id = ?",
			false, model_answer_id])
	end

	def self.get_tips model_answer_id
		Hint.find(:all, :conditions => ["category = ? AND model_answer_id = ?",
			true, model_answer_id])
	end
end