class Lecturer < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks

	#concerns
	include Searchable

	#Validations

	#Relations
	has_and_belongs_to_many :courses, join_table: "courses_lecturers"
	has_and_belongs_to_many :worked_with, class_name:"TeachingAssistant",	join_table: "lecturers_teaching_assistants"
	
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy

	has_many :topics
	has_many :tracks, as: :owner
	has_many :problems, as: :ownerm
	has_many :model_answers, as: :owner
	has_many :method_constraints, as: :owner
	has_many :method_parameters, as: :owner
	has_many :variable_constraints, as: :owner
	has_many :test_cases, as: :owner
	has_many :hints, as: :owner
	has_many :acknowledgements, dependent: :destroy
	
	#Scoops
	
	#Methods

	# [Advanced Search - Story 1.23]
	# search for lecturers
	# Parameters: hash of search options
	# Returns: A hash with search results according to the keyword and other options
	# Author: Ahmed Elassuty
	def self.search(params)
		if params[:keyword].present?
			case params[:options]
				when "exactly match"
					tire.search do
						query { string "name:#{params[:keyword]}" }
					end
				when "includes"
					tire.search do
						query { string "name:*#{params[:keyword]}*" }
					end
				when "starts with"
					tire.search do
						query { string "name:#{params[:keyword]}*" }
					end
				when "ends with"
					tire.search do
						query { string "name:*#{params[:keyword]}" }
					end
			end
		end
	end
end
