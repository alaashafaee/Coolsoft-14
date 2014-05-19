class Course < ActiveRecord::Base

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
	
	#Validations
	validates :name, presence: true
	validates :link, :format => /\Ahttps?:\/\/((w{3})[.])?([\w]|-)+(\.com|\.org|\.guc|\.edu|\.eg|\.gov|\.biz|\.info|\.net)+((\?|#|\/)([\S])*)?\z/
	validates :description, presence: true
	validates :code, presence: true
	validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: Date.today.year,
													 message: "is not valid"}
	validates :semester, presence: true, numericality: true

	#Relations
	has_and_belongs_to_many :TAs, class_name:"TeachingAssistant", join_table: "courses_teaching_assistants"
	has_and_belongs_to_many :lecturers, join_table: "courses_lecturers"
	
	has_one :discussion_board, dependent: :destroy	
	has_many :topics, :order => 'order_factor', dependent: :destroy
	has_many :acknowledgements, dependent: :destroy
	has_many :course_students
	has_many :students, through: :course_students
	has_many :contests, dependent: :destroy
	has_many :assignments, dependent: :destroy

	has_many :tags, as: :tager
	has_many :resources, dependent: :destroy

	accepts_nested_attributes_for :resources, :reject_if => :all_blank, :allow_destroy => true
	
	#Scoops
	
	#Methods
	# [Integrating_Akram_Device - Story 4.1]
	# Checks if the user with id :id has the access to edit , create this course
	# Parameters: The id of the user
	# Returns: True in case he has access else False
	# Author: Mussab ElDash
	def can_edit(user)
		if user
			can_edit = user.courses.include?(self)
		else
			false
		end
	end

	# [Simple Search - Story 1.22]
	# search for courses
	# Parameters: keyword
	# Returns: A hash with search results according to the keyword
	# Author: Ahmed Elassuty
	def self.simple_search(keyword)
		where("name LIKE ? or code LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
	end

	# [Advanced Search - Story 1.23]
	# search for courses
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
