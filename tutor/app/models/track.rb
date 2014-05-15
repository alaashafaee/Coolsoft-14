class Track < ActiveRecord::Base

	#Validations
	validates :difficulty, presence: true
	validates :title , presence: true

	#Relations
	has_many :problems, dependent: :destroy

	belongs_to :topic	
	belongs_to :owner, polymorphic: true

	#Scoops

	#Methods

	def duplicate
		return dup
	end
	# def duplicate
	# 	@tra = dup 
	# 	problems.each do |problem|
	# 		pro = problem.dup
	# 		@tra.problems << pro
	# 	end
	# 	return @tra 
	# end
end
