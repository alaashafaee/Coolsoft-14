class Resource < ActiveRecord::Base
	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
	
	#Validations
	validates :name, presence: true 
	validates :description, presence: true
	validates :code, presence: true
	validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: Date.today.year,
													 message: "is not valid"}
	validates :semester, presence: true, numericality: true

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true
	#Scoops
	
	#Methods

end
