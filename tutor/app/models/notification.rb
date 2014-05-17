class Notification < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :receiver, polymorphic: true

	#Methods

	# [Notification sending-story 2.9]
	# Sends notification to the lecturer of the course when a student signs up to it
	# Parameters:
	#	lecturer_id: the id of the lecturer
	#	student_id : the id of the student who subscribed 
	# Returns: None
	# Author: Ahmed Atef
	def self.lecturer_notify lecturer_id,course_id,student_id
		lecturer = Lecturer.find_by_id(lecturer_id)
		student = Student.find_by_id(student_id)
		course = Course.find_by_id(course_id)
		new_notification = Notification.new
		new_notification.message = "<a href= '/students/#{student.id}'>
		#{student.name}</a> subscribed to your course #{course.name}"
		new_notification.save
		lecturer.notifications << new_notification
	end

	# [Notification sending-story 2.9]
	# Sends notifications to the students of the course when an assignment is added
	# Parameters:
	#	assignment_id: the id of the assignment added
	# Returns: None
	# Author: Ahmed Atef
	def self.assignments_notify assignment_id
		assignment = Assignment.find_by_id(assignment_id)
		course = Course.find_by_id(assignment.course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			new_notification.message = "Assignment <a href= '/assignments/#{assignment.id}'>
			#{assignment.title}</a> has been posted for the course #{course.name}"	
			new_notification.save
			student.notifications << new_notification
		end
	end

	# [Notification sending-story 2.9]
	# Sends notifications to the students of the course when a contest is created
	# Parameters:
	#	course_id: the id of the course of the contest
	#	contest_id: the id of the contest created 
	# Returns: None
	# Author: Ahmed Atef
	def self.contests_notify course_id,contest_id
		contest = Contest.find_by_id(contest_id)
		course = Course.find_by_id(course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			new_notification.message = "Contest <a href= '/contests/#{contest.id}'>
			#{contest.title}</a> has been created for the course #{course.name}"
			new_notification.save
			student.notifications << new_notification
		end
	end

	# [Notification sending-story 2.9]
	# Sends notification to the student when the student is acknowledged
	# Parameters:
	#	student_id : the id of the student being acknowledged
	#	lecturer_id: the id of the lecturer who is acknowleding
	# Returns: None
	# Author: Ahmed Atef
	def self.acknowledgement_notify student_id,lecturer_id,acknowledgement_id
		student = Student.find_by_id(student_id)
		lecturer = Lecturer.find_by_id(lecturer_id)
		acknowledgement = Acknowledgement.find_by_id(acknowledgement_id)
		new_notification = Notification.new
		new_notification.message = "#{lecturer.name} has sent you an acknowledgement saying 
		'#{acknowledgement.message}'"
		new_notification.save
		student.notifications << new_notification
	end	

	# [Notification sending-story 2.9]
	# Sends notification to the students of a course when the lecturer 
	# 	activate/deactivate the discussion board
	# Parameters:
	#	discussion_board_id: the id of the discussion board being toggled
	# Returns: None
	# Author: Ahmed Atef
	def self.notify_students_discussion_board discussion_board_id
		discussion_board = DiscussionBoard.find_by_id(discussion_board_id)
		course = Course.find_by_id(discussion_board.course_id)
		students = course.students
		students.each do |student|
			new_notification = Notification.new
			if discussion_board.activated
				new_notification.message = "The discussion board for the course 
				<a href= '/courses/#{course.id}'> #{course.name} </a>has been activated"
			else
				new_notification.message = "The discussion board for the course 
				<a href= '/courses/#{course.id}'> #{course.name} </a>has been deactivated"
			end
			new_notification.save
			student.notifications << new_notification
		end
	end

end
