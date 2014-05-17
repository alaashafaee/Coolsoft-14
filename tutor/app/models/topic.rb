class Topic < ActiveRecord::Base

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
		
	#Validations
	validates :title, :description, presence: true
	validates :title, :description, uniqueness: true

	#Relations
	has_many :tracks, :order => 'difficulty', dependent: :destroy
	belongs_to :course
	belongs_to :owner, class_name: "Lecturer", foreign_key: :lecturer_id

	#Methods

	# [Advanced Search - Story 1.23]
	# search for topics
	# Parameters: hash of search options
	# Returns: A hash with search results according to the keyword and other options
	# Author: Ahmed Elassuty
	def self.search(params)
		if params[:keyword].present?
			case params[:options]
				when "exactly match"
					tire.search do
						query { string "title:#{params[:keyword]}" }
					end
				when "includes"
					tire.search do
						query { string "title:*#{params[:keyword]}*" }
					end
				when "starts with"
					tire.search do
						query { string "title:#{params[:keyword]}*" }
					end
				when "ends with"
					tire.search do
						query { string "title:*#{params[:keyword]}" }
					end
			end
		end
	end

	# [Course Sign-Up - Story 2.6]
	# Update the the progress of all students for a topic in a
	#	specfic course 
	# Parameters:
	#	Topic: the topic in which the progress of students should be updated
	# Returns: none
	# Author: Mohamed Saeed
	def self.update_track_progression topic
		course = Course.find_by_id(topic.course_id)
		course.students.each do |student|
			progress = TrackProgression.create(level: 0, topic_id: topic.id)
			student.progressions << progress
		end
	end

end
