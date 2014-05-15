class ProblemOpeningTime < ActiveRecord::Base

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
	
	#Validations
	
	#Relations
	belongs_to :problem
	belongs_to :student

	#Scoops
	
	#Methods
end
