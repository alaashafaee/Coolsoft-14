class TeachingAssistant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	#Validations

	#Relations
	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"

	#Scoops
	#Methods



end
