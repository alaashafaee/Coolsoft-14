class TeachingAssistant < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable,
			:validatable, :confirmable

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks

	#concerns
	include Searchable

	mount_uploader :profile_image, ProfileImageUploader

	#Validations
	validate :duplicate_email
	validates :name, presence: true
	validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :graduated_from, presence: true
	validates_format_of :graduated_from, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :graduated_year, presence: false, numericality: {only_integer: true, 
		greater_than_or_equal_to: Date.today.year-90, less_than_or_equal_to: Date.today.year}
	validates :degree, presence: true
	validates_format_of :degree, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :university, presence: true
	validates_format_of :university, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :department, presence: true
	validates_format_of :department, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :dob, presence: true

	#Relations
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy

	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"

	has_many :tracks, as: :owner
	has_many :problems, as: :owner
	has_many :model_answers, as: :owner
	has_many :method_constraints, as: :owner
	has_many :method_parameters, as: :owner
	has_many :variable_constraints, as: :owner
	has_many :test_cases, as: :owner
	has_many :hints, as: :owner

	#Scoops

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
end