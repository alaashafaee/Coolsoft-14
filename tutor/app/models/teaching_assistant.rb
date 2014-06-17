class TeachingAssistant < ActiveRecord::Base
	
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable,
		:validatable, :confirmable

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks

	#concerns
	include Searchable

	#Uploader
	mount_uploader :profile_image, ProfileImageUploader

	#Validations
	validate :duplicate_email
	validate :password_complexity
	validate :letters_only
	validates :name, presence: true
	validates :graduated_from, presence: true
	validates :graduated_year, presence: false, numericality: {only_integer: true, 
		greater_than_or_equal_to: Date.today.year-90, less_than_or_equal_to: Date.today.year}
	validates :degree, presence: true
	validates :degree, inclusion: ["BSc", "MSc"]
	validates :university, presence: true
	validates :department, presence: true

	#Relations
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy

	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"

	has_many :tracks, as: :owner
	has_many :model_answers, as: :owner
	has_many :method_constraints, as: :owner
	has_many :method_parameters, as: :owner
	has_many :variable_constraints, as: :owner
	has_many :test_cases, as: :owner
	has_many :hints, as: :owner
	has_many :tags, as: :owner
	
	has_many :problems, class_name:"Problem", as: :owner
	
	has_many :contests, as: :owner
	has_many :contest_problems, class_name:"Cproblem", as: :owner

	has_many :assignments, as: :owner
	has_many :assignment_problems, class_name:"AssignmentProblem", as: :owner
	has_many :grades, as: :editor

	has_many :resources, as: :owner
	has_many :notes, as: :owner
	has_many :notifications, as: :receiver
	
	#Methods
	# [Advanced Search - Story 1.23]
	# search for students
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

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Checks if the email is already registered in tables: Lecturer and Student
	# 	before registering the email for table: TeachingAssistant
	# Parameters: None
	# Returns: None
	# Author: Khaled Helmy
	def duplicate_email
		if Student.find_by email: email or Lecturer.find_by email: email
			errors.add(:email, "has already been taken")
		end
	end

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Checks for the strength of the password used in the registration process where it
	# 	doesn't allow weak passwords by requiring the used password to have at least one
	# 	uppercase letter, one lowercase letter and one digit
	# Parameters: none
	# Returns: none
	# Author: Khaled Helmy
	def password_complexity
		if password.present? and not password.match(/(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+/)
			errors.add(:password, "must include at least one lowercase letter, " +
				"one uppercase letter, and one digit")
		end
	end

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Checks for the format of certain fields [name, university, faculty, major] to
	# 	contain letters only.
	# Parameters: none
	# Returns: none
	# Author: Khaled Helmy
	def letters_only
		regex = /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
		validates_format_of :name, :with => regex
		validates_format_of :graduated_from, :with => regex
		validates_format_of :university, :with => regex
		validates_format_of :department, :with => regex
	end

end