require 'spec_helper'

describe Notification do
	before(:each) do
		@course = Course.new(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", code:"CSEN1", year:2014, semester:1,
				link: "http://www.test.org/")
		@course.save!
		@lecturer = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789', 
			password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
		@lecturer.save!
		@student1 = Student.new(email: '1@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				university: "GUC", semester: 4, faculty: "MET",major: "cs")
		@student1.save!
		@student2 = Student.new(email: '2@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentII',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				university: "GUC", semester: 4, faculty: "MET",major: "cs")
		@student2.save!
		@student3 = Student.new(email: '3@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentIII',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				university: "GUC", semester: 4, faculty: "MET",major: "cs")
		@student3.save!
	end

	it "sends notifications to students when assigments are posted" do
		assignment = Assignment.new(
		title: 'rspec assignemt',
		description: 'This is a test assignemnt',
		due_date: Date.new(2015,1,1))
		@course.assignments << assignment
		@course.students << @student1
		@course.students << @student2
		NotificationsController.skip_before_filter :authenticate!
		Notification.assignments_notify(assignment.id)
		expect(@student1.notifications.last.message).to eq(
		"Assignment <a href= '/assignments/#{assignment.id}'>
			#{assignment.title}</a> has been posted for the course #{@course.name}")
		expect(@student1.notifications.count).to eq(1)
		expect(@student2.notifications.count).to eq(1)
		expect(@student3.notifications.count).to eq(0)
	end

	it "sends notifications to students when contest is created" do
		contest = Contest.create(title: 'TestContest', description: 'Some description')
		@course.contests << contest
		@course.students << @student1
		@course.students << @student2
		NotificationsController.skip_before_filter :authenticate!
		Notification.contests_notify(@course.id, contest.id)
		expect(@student1.notifications.last.message).to eq(
		"Contest <a href= '/contests/#{contest.id}'>
			#{contest.title}</a> has been created for the course #{@course.name}")
		expect(@student1.notifications.count).to eq(1)
		expect(@student2.notifications.count).to eq(1)
		expect(@student3.notifications.count).to eq(0)
	end

	it "sends notifications to lecturer when student signs up to his course" do
		@lecturer.courses << @course
		@course.students << @student1
		NotificationsController.skip_before_filter :authenticate!
		Notification.lecturer_notify(@lecturer.id, @course.id, @student1.id)
		expect(@lecturer.notifications.last.message).to eq(
		"<a href= '/students/#{@student1.id}'>
		#{@student1.name}</a> subscribed to your course #{@course.name}")
		expect(@lecturer.notifications.count).to eq(1)
	end

	it "sends notifications to lecturer when lecturer acknowledge student" do
		acknowledgement = Acknowledgement.create(message: 'GoodJob')
		@student1.acknowledgements << acknowledgement
		NotificationsController.skip_before_filter :authenticate!
		Notification.acknowledgement_notify(@student1.id, @lecturer.id, acknowledgement.id)
		expect(@student1.notifications.last.message).to eq(
		"#{@lecturer.name} has sent you an acknowledgement saying 
		'#{@student1.acknowledgements.last.message}'")
		expect(@student1.notifications.count).to eq(1)
	end

	it "sends notifications to students when lecturer toggle discussion Board" do
		@lecturer.courses << @course
		discussion_board = DiscussionBoard.new(title: "Test DB")
		discussion_board.save!
		@course.discussion_board = discussion_board
		@course.students << @student1
		@course.students << @student2
		NotificationsController.skip_before_filter :authenticate!
		Notification.notify_students_discussion_board(@course.discussion_board.id)
		expect(@student1.notifications.last.message).to eq("The discussion board for the course 
				<a href= '/courses/#{@course.id}'> #{@course.name} </a>has been deactivated")
		expect(@student1.notifications.count).to eq(1)
		expect(@student2.notifications.count).to eq(1)
		discussion_board2 = DiscussionBoard.new(title: "Test DB", activated: true)
		discussion_board2.save!
		@course.discussion_board = discussion_board2
		Notification.notify_students_discussion_board(@course.discussion_board.id)
		expect(@student1.notifications.last.message).to eq("The discussion board for the course 
				<a href= '/courses/#{@course.id}'> #{@course.name} </a>has been activated")

	end

end		
