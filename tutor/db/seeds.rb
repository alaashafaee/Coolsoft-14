# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts("**************************************************************")
puts("                      Creating records                    ")
puts("**************************************************************")

puts("# ---------------------------Admins-----------------------------------")
	Admin.create(name: "Admin")

puts("# ---------------------------Lecturers-----------------------------")
	l = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
	l.save!
	l = Lecturer.new(email: '2@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "Uni", department: "Dep")
	l.save!

puts("# ---------------------------Students-----------------------------")
	s = Student.new(email: '1@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6, 
		advising: false, probation: false)
	s.save!
	s = Student.new(email: '2@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 6, 
		advising: true, probation: true)
	s.save!
	s = Student.new(email: '3@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentIII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 6, 
		advising: false, probation: true)
	s.save!
	s = Student.new(email: '4@student.com', password: '123456789', 
		password_confirmation: '123456789', name: 'StudentIV',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "Fac", university: "Uni", major: "Maj", semester: 8, 
		advising: true, probation: false)
	s.save!

puts("# ---------------------------TeachingAssistants-----------------------------")
	t = TeachingAssistant.new(email: '1@ta.com', password: '123456789', 
		password_confirmation: '123456789', name: 'TAI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "MSc", university: "GUC", department: "MET",
		graduated_from: "GUC", graduated_year: 2005)
	t.save!
	t = TeachingAssistant.new(email: '2@ta.com', password: '123456789', 
		password_confirmation: '123456789', name: 'TAII',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "BSc", university: "Uni", department: "Dep",
		graduated_from: "Uni", graduated_year: 2009)
	t.save!

puts("# --------------------------Courses------------------------------")

	Course.create(name:"Data Structures and Alogrithms", description:"This is a very easy course", code:"CSEN1", year:2014, semester:1)
	Course.create(name:"Computer Programming Lab", description:"This course's evaluation system is the bad", code:2, year:2014, semester:1)
	Course.create(name:"Course3", description:"This is course three", code:3, year:2014, semester:1)
	Course.create(:name => "CS 2", description:"This is course four", :code => "cs2", :year => 2014, :semester => 2, :university => "GUC")
	Course.create(:name => "CS 3", description:"This is course five", :code => "cs3", :year => 2014, :semester => 3, :university => "GUC")
	Course.create(:name => "CS 4", description:"This is course six", :code => "cs4", :year => 2014, :semester => 4, :university => "AUC")
	Course.create(:name => "CS 5", description:"This is course seven", :code => "cs5", :year => 2014, :semester => 5, :university => "AUC")

puts("# --------------------------Course_Student------------------------------")
	CourseStudent.create(share: true)

puts("# --------------------------DiscussionBoards------------------------------")
	DiscussionBoard.create(title:"DiscussionBoard1", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard2", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard3", activated: true)

puts("# --------------------------Posts------------------------------")
	Post.create(title:"My 1st Post", content: "The Main Objective is to be a winner", views_count: 20)
	Post.create(title:"My 2nd Post", content: "It is very hard to keep in this life, be happy", views_count: 100)
	Post.create(title:"My 3th Post", content: "Post3")
	Post.create(title:"My 4th Post", content: "Post4")

puts("# --------------------------Replies---------------------------")
	Reply.create(content: "Reply1")
	Reply.create(content: "Reply2")
	Reply.create(content: "Reply3")
	Reply.create(content: "Reply4")
	Reply.create(content: "Reply5")

puts("# --------------------------Topics------------------------------")
	Topic.create(title: "Topic1", description: "This is Topic1 description")
	Topic.create(title: "Topic2", description: "This is Topic2 description")
	Topic.create(title: "Topic3", description: "This is Topic3 description")

puts("# -----------------------Hints---------------------------")

	Hint.create(message: "Do not Try to Solve CS problem-1", category: false, time: 5)
	Hint.create(message: "Do not Try to Solve CS problem-2", category: true)
	Hint.create(message: "Do not Try to Solve CS problem-3", category: false)
	
puts("# -----------------------ModelAnswer---------------------------")
	ModelAnswer.create(title: "Answer1", answer: "System.out.println('SQL baaaad')-1")
	ModelAnswer.create(title: "Answer2", answer: "System.out.println('SQL baaaad')-2")
	ModelAnswer.create(title: "Answer3", answer: "System.out.println('SQL baaaad')-3")
	ModelAnswer.create(title: "Answer4", answer: "System.out.println('SQL baaaad')-4")
	ModelAnswer.create(title: "Answer5", answer: "System.out.println('SQL baaaad')-5")
	ModelAnswer.create(title: "Answer6", answer: "System.out.println('SQL baaaad')-6")

puts("# -----------------------Test Cases---------------------------")
	TestCase.create(output: "hello World 1", input:"x = 0")
	TestCase.create(output: "hello World 2", input:"x = 1")
	TestCase.create(output: "hello World 3", input:"x = 2")
	TestCase.create(output: "5\n", input:"10 2")
	TestCase.create(output: "2.5\n", input:"5 2")
	TestCase.create(output: "x", input:"10 0")

puts("# -----------------------Method Parameters---------------------------")
	MethodParameter.create(parameter:"MethodParameters 1", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 2", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 3", params_type: "int")

puts("# -----------------------Variable Constraints---------------------------")
	VariableConstraint.create(variable_name: "VariableConstraint 1")
	VariableConstraint.create(variable_name: "VariableConstraint 2")
	VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# -----------------------Problems---------------------------")
	Problem.create(title: "Problem 1", description: "Given two numbers a and b, output a/b", incomplete: false)
	Problem.create(title: "Problem 2", description: "This is very hard Problem", incomplete: false)
	Problem.create(title: "Problem 3", description: "This wont be a hard Problem", incomplete: false)
	Problem.create(title: "Problem 4", description: "This will be very easy Problem", incomplete: true)
	Problem.create(title: "Problem 5", description: "This is very easy Problem", incomplete: true)

puts("# -----------------------Tracks---------------------------")
	Track.create(title: "Track 1", difficulty: 0)
	Track.create(title: "Track 2", difficulty: 1)
	Track.create(title: "Track 3", difficulty: 2)
	Track.create(title: "Track 4", difficulty: 3)

puts("# -----------------------Solutions---------------------------")
	Solution.create(code:"println(My first solution)", length:5, status:0)
	Solution.create(code:"println(My second solution)", length:5, status:1)
	Solution.create(code:"println(My third solution)", length:5, status:3)

puts("# -----------------------TrackProgression---------------------------")
	TrackProgression.create(:level => 1, :topic_id => 1)
	TrackProgression.create(:level => 1, :topic_id => 1)
	TrackProgression.create(:level => 1, :topic_id => 1)
	TrackProgression.create(level: 0, topic_id: 1)
	TrackProgression.create(level: 2, topic_id: 2)

puts("# -----------------------Attempts---------------------------")
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(success: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)
	Attempt.create(failure: true)

puts("#-----------------------Recommendations-----------------------")
	Recommendation.create(problem_id:1, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:2, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:5, student_id:1, recommender_id:2)

puts("# -------------------------------------------------------")
puts("**************************************************************")
puts("                      Creating Relations                    ")
puts("**************************************************************")

puts("# -----------------------Lecturers---------------------------")
	Lecturer.first.topics << Topic.first
	Lecturer.first.tracks << Track.first
	Lecturer.first.problems << Problem.first
	Lecturer.first.courses << Course.first
	Lecturer.first.courses << Course.find_by_id(2)
	Lecturer.first.posts << Post.first
	Lecturer.first.posts << Post.find_by_id(2)
	Lecturer.first.replies << Reply.first
	Lecturer.first.replies << Reply.find_by_id(2)
	Lecturer.first.replies << Reply.find_by_id(3)
	Lecturer.first.replies << Reply.find_by_id(4)
	Lecturer.find_by_id(1).courses << Course.find_by_code("cs2")
	Lecturer.find_by_id(1).courses << Course.find_by_code("cs3")
	Lecturer.find_by_id(2).courses << Course.find_by_code("cs4")
	Lecturer.find_by_id(2).courses << Course.find_by_code("cs5")

puts("# -----------------------Students---------------------------")
	Student.first.course_students << CourseStudent.first
	Student.first.solutions << Solution.first
	Student.first.solutions << Solution.find_by_id(2)
	Student.first.solutions << Solution.find_by_id(3)
	Student.first.attempts << Attempt.first
	Student.first.attempts << Attempt.find_by_id(2)
	Student.first.attempts << Attempt.find_by_id(3)
	Student.first.attempts << Attempt.find_by_id(4)
	Student.first.attempts << Attempt.find_by_id(5)
	Student.first.attempts << Attempt.find_by_id(6)
	Student.first.attempts << Attempt.find_by_id(7)
	Student.first.attempts << Attempt.find_by_id(8)
	Student.first.attempts << Attempt.find_by_id(9)
	Student.first.attempts << Attempt.find_by_id(10)
	Student.first.attempts << Attempt.find_by_id(11)
	Student.first.attempts << Attempt.find_by_id(12)
	Student.first.attempts << Attempt.find_by_id(13)
	Student.find(2).courses << Course.first
	Student.find(3).courses << Course.first
	Student.find(4).courses << Course.first

	Student.find_by_id(2).progressions << TrackProgression.first
	Student.find_by_id(3).progressions << TrackProgression.find_by_id(2)
	Student.find_by_id(4).progressions << TrackProgression.find_by_id(3)
	Student.first.progressions << TrackProgression.find_by_id(4)
	Student.first.progressions << TrackProgression.find_by_id(5)

	# Other way to add Course into student, but it will require getting Course_student via searching
	# since the table has key on (student_id and course_id)then the array will always be 1 elemet [0]
	Student.find_by_id(2).courses << Course.find_by_id(2)
	CourseStudent.where(student_id:2, course_id:2)[0].update(share: true)
	Student.find_by_id(1).courses << Course.find_by_id(2)
	CourseStudent.where(student_id:1, course_id:2)[0].update(share: true)

puts("# -----------------------TeachingAssistants---------------------------")
	TeachingAssistant.first.courses << Course.first
	TeachingAssistant.find_by_id(2).courses << Course.find_by_id(2)

puts("# -----------------------Problems---------------------------")
	Problem.find_by_id(3).test_cases << TestCase.first
	Problem.first.model_answers << ModelAnswer.first
	Problem.first.model_answers << ModelAnswer.find_by_id(2)
	Problem.first.test_cases << TestCase.find_by_id(4)
	Problem.first.test_cases << TestCase.find_by_id(5)
	Problem.first.test_cases << TestCase.find_by_id(6)
	Problem.first.solutions << Solution.first

	Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(3)
	Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(4)
	Problem.find_by_id(2).test_cases << TestCase.first
	Problem.find_by_id(2).solutions << Solution.find_by_id(2)

	Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(5)
	Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(6)
	Problem.find_by_id(3).solutions << Solution.find_by_id(3)

	Problem.first.attempts << Attempt.first
	Problem.first.attempts << Attempt.find_by_id(2)
	Problem.first.attempts << Attempt.find_by_id(3)
	Problem.first.attempts << Attempt.find_by_id(4)
	Problem.first.attempts << Attempt.find_by_id(5)
	Problem.first.attempts << Attempt.find_by_id(6)
	Problem.first.attempts << Attempt.find_by_id(7)
	Problem.first.attempts << Attempt.find_by_id(8)
	Problem.first.attempts << Attempt.find_by_id(9)
	Problem.first.attempts << Attempt.find_by_id(10)
	Problem.first.attempts << Attempt.find_by_id(11)
	Problem.first.attempts << Attempt.find_by_id(12)
	Problem.first.attempts << Attempt.find_by_id(13)

puts("# -----------------------Hints---------------------------")
	Problem.first.model_answers.first.hints << Hint.first

puts("# ---------------------- Tracks --------------------------")
	Track.first.problems << Problem.first
	Track.first.problems << Problem.find_by_id(2)
	Track.find_by_id(2).problems << Problem.find_by_id(3)
	Track.find_by_id(2).problems << Problem.find_by_id(4)
	Track.find_by_id(3).problems << Problem.find_by_id(5)

puts("# ---------------------- Topics -------------------------")
	Topic.first.tracks << Track.first
	Topic.first.tracks << Track.find_by_id(2)
	Topic.find_by_id(2).tracks << Track.find_by_id(3)
	Topic.find_by_id(3).tracks << Track.find_by_id(4)

puts("# --------------------- Courses -------------------------")
	Course.first.topics << Topic.first
	Course.first.discussion_board = DiscussionBoard.first
	Course.first.topics << Topic.find_by_id(2)
	Course.find_by_id(2).topics << Topic.find_by_id(3)
	Course.find_by_id(2).discussion_board = DiscussionBoard.last
	Course.first.course_students << CourseStudent.first

puts("# ----------------- DiscussionBoard -----------------------")
	DiscussionBoard.first.posts << Post.first
	DiscussionBoard.first.posts << Post.find_by_id(2)

puts("# ---------------------------------------------------------")
