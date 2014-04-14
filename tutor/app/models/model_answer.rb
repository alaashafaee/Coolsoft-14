class ModelAnswer < ActiveRecord::Base
	#Validations
	validates :answer , :presence => true
	validates :answer , :length => { :minimum => 1 }
	#Relations
	belongs_to :problem
	belongs_to :owner, polymorphic: true
	has_many :method_constraints, dependent: :destroy
	has_many :method_parameters, dependent: :destroy
	has_many :variable_constraints, dependent: :destroy
	has_many :hints, dependent: :destroy
	#Scoops
	#Methods
end
