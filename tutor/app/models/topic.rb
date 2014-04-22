class Topic < ActiveRecord::Base

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
		
	#Validations
	validates :title, :description, presence: true
	validates :title, :description, uniqueness: true

	#Relations
	has_many :tracks, dependent: :destroy
	belongs_to :course
	belongs_to :owner, class_name: "Lecturer", foreign_key: :lecturer_id

end
