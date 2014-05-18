class ModelAnswer < ActiveRecord::Base

	#Validations
	validates :title, presence: true
	validates :answer, presence: true
	validates_uniqueness_of :title, :scope => :problem_id

	#Relations
	belongs_to :problem
	belongs_to :owner, polymorphic: true

	has_many :method_constraints, dependent: :destroy
	has_many :variable_constraints, dependent: :destroy
	has_many :hints, dependent: :destroy

	#Scoops

	#Methods

end
