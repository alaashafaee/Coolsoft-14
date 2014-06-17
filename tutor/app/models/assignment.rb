class Assignment < ActiveRecord::Base

	default_scope order('due_date DESC')
	#Validations
	validates :title, presence: true
	validate :validate_start_date_before_today

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	has_many :problems, class_name:"AssignmentProblem", dependent: :destroy

	#Scoops

	#Methods
	def validate_start_date_before_today
		if due_date <= Time.now
			errors.add(:due_date," :Please change,already expired")
		end
	end

end
