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

	def self.assignments_notify assignment_id
		assignment = Assignment.find_by_id(assignment_id)
		course = Course.find_by_id(assignment.course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			new_notification.message = "Assignment #{assignment.title} has been posted for the 
				course #{course.name}"	
			new_notification.save
			student.notifications << new_notification
		end
	end

	def self.contests_notify course_id,contest_id
		contest = Contest.find_by_id(contest_id)
		course = Course.find_by_id(course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			new_notification.message = "Contest #{assignment.title} has been created for the 
				course #{course.name}"	
			new_notification.save
			student.notifications << new_notification
		end
	end

	def self.acknowledgement_notify student_id,lecturer_id
		student = Student.find_by_id(student_id)
		lecturer = Lecturer.find_by_id(lecturer_id)
		new_notification = Notification.new
		new_notification.message = "#{lecturer.name} has sent you an acknowledgement"
		new_notification.save
		student.notifications << new_notification
	end	

end
