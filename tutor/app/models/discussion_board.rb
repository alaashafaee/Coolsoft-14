class DiscussionBoard < ActiveRecord::Base

	#Validations
	validates :title, presence: true

	#Relations
	belongs_to :course
	has_many :posts, dependent: :destroy

	def notify_students
		discussion_board = DiscussionBoard.find_by_id(self.id)
		course = Course.find_by_id(discussion_board.course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			if discussion_board.activated 
				new_notification.message = "The discussion board for the course 
				#{course.name} has been activated"
			else
				new_notification.message = "The discussion board for the course 
				#{course.name} has been deactivated"
			end		
			new_notification.save
			student.notifications << new_notification
		end
	end

end
