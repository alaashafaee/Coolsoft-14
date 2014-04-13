class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	#Validations
	validates :name, presence: true
	validates :dob, presence: true
	validates :faculty, presence: true
	validates :major, presence: true
	validates :semester, presence: true

	#Relations
	# has_many :student_courses
	# has_many :courses, through: :student_courses
	has_one :user, as: :sub

	has_many :solutions, dependent: :destroy

	has_many :progressions, class_name: "TrackProgression"

	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	
	has_and_belongs_to_many :courses, join_table: 'courses_students'
	
	#Scoops
	#Methods


end
