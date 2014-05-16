class Notification < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :receiver, polymorphic: true

	#Scoops

	def self.lecturer_notify lecturer_id,course_id,student_id
		lecturer = Lecturer.find_by_id(lecturer_id)
		student = Student.find_by_id(student_id)
		course = Course.find_by_id(course_id)
		new_notification = Notification.new
		new_notification.message = "#{student.name} subscribed to your course #{course.name}"
		new_notification.save
		lecturer.notifications << new_notification
	end


end
