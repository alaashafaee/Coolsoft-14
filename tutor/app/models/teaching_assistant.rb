class TeachingAssistant < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	
	mount_uploader :profile_image, ProfileImageUploader

	#Validations
	validates :name, presence: true
	validates :graduated_from, presence: true
	validates :graduated_year, presence: true, numericality: {only_integer: true, message: "must be a number"}
	validates :department, presence: true

	#Relations
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy

	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"

	has_many :tracks, 	as: :owner
	has_many :problems, 	as: :owner
	has_many :model_answers, 	as: :owner
	has_many :method_constraints, 	as: :owner
	has_many :method_parameters, 	as: :owner
	has_many :variable_constraints,	 as: :owner
	has_many :test_cases,	 as: :owner
	has_many :hints, 	as: :ownert

	#Scoops

	#Methods

end
