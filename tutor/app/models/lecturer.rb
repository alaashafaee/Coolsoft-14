class Lecturer < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
    		:recoverable, :rememberable, :trackable, :validatable
	
	#Validations

	#Relations
	has_one :user, as: :sub

	has_and_belongs_to_many :courses, join_table: "courses_lecturers"
	has_and_belongs_to_many :worked_with, class_name:"TeachingAssistant", join_table: "lecturers_teaching_assistants"

	has_many :topics
	
	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy
	
	#Scoops
	
	#Methods
end
