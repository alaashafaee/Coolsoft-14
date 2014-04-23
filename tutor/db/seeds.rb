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
	Lecturer.create!(name:"Lecturer1", email:"1@lecturer.com", password:"123456789")
	Lecturer.create!(name:"Lecturer1", email:"2@lecturer.com", password:"123456789")

puts("# ---------------------------Students-----------------------------")
	Student.create!(name:"Student1", email:"1@student.com", password:"123456789")
	Student.create!(name:"Student2", email:"2@student.com", password:"123456789")

puts("# ---------------------------TeachingAssistants-----------------------------")
	TeachingAssistant.create(name:"TA1", email:"1@ta.com", password:"123456789")
	TeachingAssistant.create(name:"TA2", email:"2@ta.com", password:"123456789")

puts("# --------------------------Courses------------------------------")
	Course.create(name:"Course1", description:"This is course one", code:1, year:2014, semester:1)
	Course.create(name:"Course2", description:"This is course two", code:2, year:2014, semester:1)
	Course.create(name:"Course3", description:"This is course three", code:3, year:2014, semester:1)

puts("# --------------------------Course_Student------------------------------")
	CourseStudent.create(share: true)

puts("# --------------------------DiscussionBoards------------------------------")
	DiscussionBoard.create(title:"DiscussionBoard1", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard2", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard3", activated: true)

puts("# --------------------------Posts------------------------------")
	Post.create(content: "The Main Objective is to be a winner", views_count: 20)
	Post.create(content: "It is very hard to keep in this life, be happy", views_count: 100)
	Post.create(content: "Post3")
	Post.create(content: "Post4")

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
	Hint.create(message: "Do not Try to Solve CS problem-1")
	Hint.create(message: "Do not Try to Solve CS problem-2")
	Hint.create(message: "Do not Try to Solve CS problem-3")

puts("# -----------------------ModelAnswer---------------------------")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-1")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-2")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-3")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-4")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-5")
	ModelAnswer.create(answer: "System.out.println('SQL baaaad')-6")

puts("# -----------------------Test Cases---------------------------")
	TestCase.create(output: "hello World 1", input:"x = 0")
	TestCase.create(output: "hello World 2", input:"x = 1")
	TestCase.create(output: "hello World 3", input:"x = 2")
	TestCase.create(output: "5\n", input:"10 2")
	TestCase.create(output: "2.5\n", input:"5 2")
	TestCase.create(output: "x", input:"10 0")

puts("# -----------------------Method Parameters---------------------------")
	MethodParameter.create(parameter:"MethodParameters 1")
	MethodParameter.create(parameter:"MethodParameters 2")
	MethodParameter.create(parameter:"MethodParameters 3")

puts("# -----------------------Variable Constraints---------------------------")
	VariableConstraint.create(variable_name: "VariableConstraint 1")
	VariableConstraint.create(variable_name: "VariableConstraint 2")
	VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# -----------------------Problems---------------------------")

	Problem.create(title:"Problem 1", description:"Given two numbers a and b, output a/b")
	Problem.create(title:"Problem 2", description:"This is very hard Problem" )
	Problem.create(title:"Problem 3", description:"This wont be a hard Problem")
	Problem.create(title:"Problem 4", description:"This will be very easy Problem")
	Problem.create(title:"Problem 5", description:"This is very easy Problem")

puts("# -----------------------Tracks---------------------------")
	Track.create(title: "Track 1" , difficulty: 0)
	Track.create(title: "Track 2" , difficulty: 1)
	Track.create(title: "Track 3" , difficulty: 2)
	Track.create(title: "Track 4" , difficulty: 3)

puts("# -----------------------Solutions---------------------------")
	Solution.create(code:"println(My first solution)", length:5, status:0)
	Solution.create(code:"println(My second solution)", length:5, status:1)
	Solution.create(code:"println(My third solution)", length:5, status:3)

puts("# -----------------------TrackProgression---------------------------")
	TrackProgression.create(level: 0, student_id: 1, topic_id: 1)
	TrackProgression.create(level: 2, student_id: 1, topic_id: 2)
	
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

	# Other way to add Course into student, but it will require getting Course_student via searching
	# since the table has key on (student_id and course_id)then the array will always be 1 elemet [0]
	Student.find_by_id(2).courses << Course.find_by_id(2)
	CourseStudent.where(student_id:2, course_id:2)[0].update(share: true)

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

puts("# -----------------------Solution---------------------------")
	Student.first.solutions << Solution.first
	Student.first.solutions << Solution.find_by_id(2)
	Student.first.solutions << Solution.find_by_id(3)

puts("# ---------------------------------------------------------")
