class Topic < ActiveRecord::Base
	
	#Validations
	validates :title, :description, presence: true
	validates :title, :description, uniqueness: true

	#Relations
	has_many :tracks,:order => 'difficulty' ,dependent: :destroy
	belongs_to :course
	belongs_to :owner, class_name: "Lecturer", foreign_key: :lecturer_id

end
