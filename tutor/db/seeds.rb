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

puts("# ----------------------- Admins ----------------------- ")

puts("# ----------------------- Lecturers ----------------------- ")
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

puts("# ----------------------- Students ----------------------- ")
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

puts("# ----------------------- TeachingAssistants ----------------------- ")
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

puts("# ----------------------- Courses ----------------------- ")

	Course.create(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", code:"CSEN1", year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name:"Computer Programming Lab", 
				description:"This course's evaluation system is the bad", code:2, year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name:"Course3", 
				description:"This is course three", code:3, year:2014, semester:1, link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 2", 
				description:"This is course four", code: "cs2", year: 2014, semester: 2, university: "GUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 3", 
				description:"This is course five", code: "cs3", year: 2014, semester: 3, university: "GUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 4", 
				description:"This is course six", code: "cs4", year: 2014, semester: 4, university: "AUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
	Course.create(name: "CS 5", 
				description:"This is course seven", code: "cs5", year: 2014, semester: 5, university: "AUC", link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")

puts("# ----------------------- Course_Student ----------------------- ")
	CourseStudent.create(share: true)

puts("# ----------------------- DiscussionBoards ----------------------- ")
	DiscussionBoard.create(title:"DiscussionBoard1", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard2", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard3", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard4", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard5", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard6", activated: true)
	DiscussionBoard.create(title:"DiscussionBoard7", activated: true)

puts("# ----------------------- Posts ----------------------- ")
	Post.create(title:"My 1st Post", content: "The Main Objective is to be a winner", views_count: 20)
	Post.create(title:"My 2nd Post", content: "It is very hard to keep in this life, be happy", views_count: 100)
	Post.create(title:"My 3th Post", content: "Post3")
	Post.create(title:"My 4th Post", content: "Post4")

puts("# ----------------------- Replies ----------------------- ")
	Reply.create(content: "Reply1")
	Reply.create(content: "Reply2")
	Reply.create(content: "Reply3")
	Reply.create(content: "Reply4")
	Reply.create(content: "Reply5")
	Reply.create(content: "Reply6")
	Reply.create(content: "Reply7")
	Reply.create(content: "Reply8")
	Reply.create(content: "Reply9")
	Reply.create(content: "Reply10")
	Reply.create(content: "Reply11")
	Reply.create(content: "Reply12")
	Reply.create(content: "Reply13")

puts("# ----------------------- Topics ----------------------- ")
	Topic.create(title: "Topic1", description: "This is Topic1 description")
	Topic.create(title: "Topic2", description: "This is Topic2 description")
	Topic.create(title: "Topic3", description: "This is Topic3 description")

puts("# ----------------------- Hints ----------------------- ")
	Hint.create(message: "Do not Try to Solve CS problem-1", category: false, time: 5, submission_counter:10)
 	Hint.create(message: "Do not Try to Solve CS problem-2", category: true, time: 5, submission_counter:10)
 	Hint.create(message: "Do not Try to Solve CS problem-3", category: false, time: 5, submission_counter:10)

puts("# ----------------------- ModelAnswer ----------------------- ")
	ModelAnswer.create(title: "Answer1", answer: "System.out.println('SQL baaaad')-1")
	ModelAnswer.create(title: "Answer2", answer: "System.out.println('SQL baaaad')-2")
	ModelAnswer.create(title: "Answer3", answer: "System.out.println('SQL baaaad')-3")
	ModelAnswer.create(title: "Answer4", answer: "System.out.println('SQL baaaad')-4")
	ModelAnswer.create(title: "Answer5", answer: "System.out.println('SQL baaaad')-5")
	ModelAnswer.create(title: "Answer6", answer: "System.out.println('SQL baaaad')-6")

puts("# ----------------------- Test Cases ----------------------- ")
	TestCase.create(output: "hello World 1", input:"x = 0")
	TestCase.create(output: "hello World 2", input:"x = 1")
	TestCase.create(output: "hello World 3", input:"x = 2")
	TestCase.create(output: "5.0\n", input:"10 2")
	TestCase.create(output: "2.5\n", input:"5 2")
	TestCase.create(output: "Infinity\n", input:"10 0")

puts("# ----------------------- Method Parameters ----------------------- ")
	MethodParameter.create(parameter:"MethodParameters 1", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 2", params_type: "int")
	MethodParameter.create(parameter:"MethodParameters 3", params_type: "int")

puts("# ----------------------- Variable Constraints ----------------------- ")
	VariableConstraint.create(variable_name: "VariableConstraint 1")
	VariableConstraint.create(variable_name: "VariableConstraint 2")
	VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# ----------------------- Problems ----------------------- ")
	## Assignments
		AssignmentProblem.create(title: "AssignmentProblem 1", description: "Your program is to use the brute-force approach in order 
			to find the Answer to Life, the Universe, and Everything. More precisely... rewrite small numbers from 
			input to output. Stop processing input after reading in the number 42. All numbers at input are integers 
			of one or two digits.", final_grade:10)
		AssignmentProblem.create(title: "AssignmentProblem 2", description: "he Antique Comedians of Malidinesia prefer 
			comedies to tragedies. Unfortunately, most of the ancient plays are tragedies. Therefore 
			the dramatic advisor of ACM has decided to transfigure some tragedies into comedies. 
			Obviously, this work is very hard because the basic sense of the play must be kept intact, 
			although all the things change to their opposites. For example the numbers: if any 
			number appears in the tragedy, it must be converted to its reversed form before 
			being accepted into the comedy play. Reversed number is a number written in arabic 
			numerals but the order of digits is reversed. The first digit becomes last and vice 
			versa. For example, if the main hero had 1245 strawberries in the tragedy, he has 
			5421 of them now. Note that all the leading zeros are omitted. That means if 
			the number ends with a zero, the zero is lost by reversing (e.g. 1200 gives 21). 
			Also note that the reversed number never has any trailing zeros. ACM needs to 
			calculate with reversed numbers. Your task is to add two reversed numbers and output their 
			reversed sum. Of course, the result is not unique because any particular number is a 
			reversed form of several numbers (e.g. 21 could be 12, 120 or 1200 before reversing). 
			Thus we must assume that no zeros were lost by reversing 
			(e.g. assume that the original number was 12).", final_grade:10)
		AssignmentProblem.create(title: "AssignmentProblem 3", description: "This wont be a hard Problem", final_grade:10)
		AssignmentProblem.create(title: "AssignmentProblem 4", description: "This will be very easy Problem", final_grade:10)
	## Contests
		Cproblem.create(title: "ContestProblem 1", description: "This is very easy Problem")
		Cproblem.create(title: "ContestProblem 2", description: "Given two numbers a and b, output a/b")
		Cproblem.create(title: "ContestProblem 3", description: "This is very hard Problem")
		Cproblem.create(title: "ContestProblem 4", description: "This wont be a hard Problem")
		Cproblem.create(title: "ContestProblem 5", description: "This will be very easy Problem")
		Cproblem.create(title: "ContestProblem 6", description: "This is very easy Problem")
	## Exercise

		Problem.create(title: "Problem 1", description: "Given two numbers a and b, output a/b",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					 {\n\t\t\n\t}\n}")
		Problem.create(title: "Problem 2", description: "This is very hard Problem",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					 {\n\t\t\n\t}\n}")
		Problem.create(title: "Problem 3", description: "This wont be a hard Problem",
					incomplete: false,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					 {\n\t\t\n\t}\n}")
		Problem.create(title: "Problem 4", description: "This will be very easy Problem",
					incomplete: true,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					 {\n\t\t\n\t}\n}")
		Problem.create(title: "Problem 5", description: "This is very easy Problem",
					incomplete: true,
					snippet: "public class CoolSoft {\n\tpublic static void main(String [] args)
					 {\n\t\t\n\t}\n}")

puts("# ----------------------- Tracks ----------------------- ")
	Track.create(title: "Track 1", difficulty: 0)
	Track.create(title: "Track 2", difficulty: 1)
	Track.create(title: "Track 3", difficulty: 2)
	Track.create(title: "Track 4", difficulty: 3)

puts("# -----------------------Solutions---------------------------")
	Solution.create(code:"println(My first solution)", length:5, status:1)
	Solution.create(code:"println(My second solution)", length:5, status:0)
	Solution.create(code:"println(My third solution)", length:5, status:3)

puts("# ----------------------- TrackProgression ----------------------- ")
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 1, topic_id: 1)
	TrackProgression.create(level: 0, topic_id: 1)
	TrackProgression.create(level: 2, topic_id: 2)

puts("# ----------------------- Attempts ----------------------- ")
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

puts("# ----------------------- Recommendations ----------------------- ")
	Recommendation.create(problem_id:1, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:2, student_id:1, recommender_id:2)
	Recommendation.create(problem_id:5, student_id:1, recommender_id:2)

puts("# ----------------------- Contests ----------------------- ")
	Contest.create(title:"Iteration", description:"If you can solve this you will get a level up",
		incomplete:false, start_time:Time.now+2.days, end_time:Time.now+7.days)
	Contest.create(title:"Recursion", description:"If you can solve this you will get 2 level up",
		incomplete:false, start_time:Time.now+3.days, end_time:Time.now+10.days)
	Contest.create(title:"DB", description:"If you can solve this you will get 4 level up",
		incomplete:false, start_time:Time.now+5.days, end_time:Time.now+12.days)

puts("# ----------------------- Contests ----------------------- ")
	ContestProgress.create!(status:true)
	ContestProgress.create!(status:true)
	ContestProgress.create!(status:true)
	ContestProgress.create!(status:false)

puts("# ----------------------- Assignments ----------------------- ")
	Assignment.create(title:"DSD Assignment_1", publish: true, due_date: Date.new(2009,6,13),
		 description:"This is your first DSD assignment. It contains exersices on basics of logic design.")
	Assignment.create(title:"DMENT Assignment_2", publish: true, due_date: Date.new(2015,1,1))
	Assignment.create(title:"DSD Assignment_3", publish: true, due_date: DateTime.now.to_date)
	Assignment.create(title:"CA Assignment", publish: false, description:"Allows practice on instruction set formats.", due_date: DateTime.now.to_date)

puts("# ----------------------- Grades ----------------------- ")
	Grade.create(grade: 100)
	Grade.create(grade: 80)


puts("**************************************************************")
puts("                      Creating Relations                    ")
puts("**************************************************************")

puts("# ----------------------- Lecturers ----------------------- ")
	## Topics
		Lecturer.first.topics << Topic.first
	## Tracks
		Lecturer.first.tracks << Track.first
	## Problems
		Lecturer.first.problems << Problem.first
		Lecturer.first.problems << Problem.find_by_id(2)
		Lecturer.first.problems << Problem.find_by_id(3)
		Lecturer.first.problems << Problem.find_by_id(4)
		Lecturer.first.problems << Problem.find_by_id(5)

		Lecturer.first.assignment_problems << AssignmentProblem.first
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(2)
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(3)
		Lecturer.first.assignment_problems << AssignmentProblem.find_by_id(4)

		Lecturer.first.contest_problems << Cproblem.first
		Lecturer.first.contest_problems << Cproblem.find_by_id(2)
		Lecturer.first.contest_problems << Cproblem.find_by_id(3)
		Lecturer.first.contest_problems << Cproblem.find_by_id(4)
		Lecturer.first.contest_problems << Cproblem.find_by_id(5)
	## Courses
		Lecturer.first.courses << Course.first
		Lecturer.first.courses << Course.find_by_id(2)
		Lecturer.first.courses << Course.find_by_code("cs2")
		Lecturer.first.courses << Course.find_by_code("cs3")
		Lecturer.find_by_id(2).courses << Course.find_by_code("cs4")
		Lecturer.find_by_id(2).courses << Course.find_by_code("cs5")
	## Posts
		Lecturer.first.posts << Post.first
		Lecturer.first.posts << Post.find_by_id(2)
	## Replies
		Lecturer.first.replies << Reply.first
		Lecturer.first.replies << Reply.find_by_id(2)
		Lecturer.first.replies << Reply.find_by_id(3)
		Lecturer.first.replies << Reply.find_by_id(4)
		Lecturer.first.replies << Reply.find_by_id(5)
		Lecturer.first.replies << Reply.find_by_id(6)
		Lecturer.first.replies << Reply.find_by_id(7)
		Lecturer.first.replies << Reply.find_by_id(8)
		Lecturer.first.replies << Reply.find_by_id(9)
		Lecturer.first.replies << Reply.find_by_id(10)
		Lecturer.first.replies << Reply.find_by_id(11)
		Lecturer.first.replies << Reply.find_by_id(12)
		Lecturer.first.replies << Reply.find_by_id(13)
	## Contests
		Lecturer.first.contests << Contest.first
		Lecturer.first.contests << Contest.find_by_id(2)
		Lecturer.first.contests << Contest.find_by_id(3)
	## Assignments
		Lecturer.first.assignments << Assignment.first
		Lecturer.first.assignments << Assignment.find_by_id(2)
		Lecturer.first.assignments << Assignment.find_by_id(3)
		Lecturer.first.assignments << Assignment.find_by_id(4)
	## Grades
		Lecturer.first.grades << Grade.first
		Lecturer.find_by_id(2).grades << Grade.find_by_id(2)

puts("# ----------------------- Students ----------------------- ")
	## CourseStudent
		Student.first.course_students << CourseStudent.first
	## Solutions
		Student.first.solutions << Solution.first
		Student.first.solutions << Solution.find_by_id(2)
		Student.first.solutions << Solution.find_by_id(3)
	## Attempts
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
	## Courses
		Student.find(2).courses << Course.first
		Student.find(3).courses << Course.first
		Student.find(4).courses << Course.first
		# Other way to add Course into student, but it will require getting Course_student via searching
		# since the table has key on (student_id and course_id)then the array will always be 1 elemet [0]
		Student.find_by_id(2).courses << Course.find_by_id(2)
		CourseStudent.where(student_id:2, course_id:2)[0].update(share: true)
		Student.first.courses << Course.find_by_id(2)
		CourseStudent.where(student_id:1, course_id:2)[0].update(share: true)
	## Tracks Progressions
		Student.find_by_id(2).progressions << TrackProgression.first
		Student.find_by_id(3).progressions << TrackProgression.find_by_id(2)
		Student.find_by_id(4).progressions << TrackProgression.find_by_id(3)
		Student.first.progressions << TrackProgression.find_by_id(4)
		Student.first.progressions << TrackProgression.find_by_id(5)
	## Contests
		Student.first.contests << Contest.first
		Student.find_by_id(2).contests << Contest.first
		Student.find_by_id(3).contests << Contest.find_by_id(2)
		Student.find_by_id(4).contests << Contest.find_by_id(3)
	## Contests progress
		Student.first.contest_progresses << ContestProgress.first
		Student.first.contest_progresses << ContestProgress.find_by_id(2)
		Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(3)
		Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(4)
	## Grades
		Student.first.grades << Grade.first
		Student.first.grades << Grade.find_by_id(2)

puts("# ----------------------- TeachingAssistants ----------------------- ")
	## Courses
		TeachingAssistant.first.courses << Course.first
		TeachingAssistant.find_by_id(2).courses << Course.find_by_id(2)

puts("# ----------------------- Posts ----------------------- ")
	## Replies
		Post.first.replies << Reply.first
		Post.first.replies << Reply.find_by_id(2)
		Post.first.replies << Reply.find_by_id(3)
		Post.first.replies << Reply.find_by_id(4)
		Post.first.replies << Reply.find_by_id(5)
		Post.first.replies << Reply.find_by_id(6)
		Post.first.replies << Reply.find_by_id(7)
		Post.first.replies << Reply.find_by_id(8)
		Post.first.replies << Reply.find_by_id(9)
		Post.first.replies << Reply.find_by_id(10)
		Post.first.replies << Reply.find_by_id(11)
		Post.first.replies << Reply.find_by_id(12)
		Post.first.replies << Reply.find_by_id(13)

puts("# ----------------------- Problems ----------------------- ")
	## TestCases
		Problem.first.test_cases << TestCase.find_by_id(4)
		Problem.first.test_cases << TestCase.find_by_id(5)
		Problem.first.test_cases << TestCase.find_by_id(6)
		Problem.find_by_id(2).test_cases << TestCase.first
		Problem.find_by_id(3).test_cases << TestCase.first
	## Model Answers
		Problem.first.model_answers << ModelAnswer.first
		Problem.first.model_answers << ModelAnswer.find_by_id(2)
		Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(3)
		Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(4)
		Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(5)
		Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(6)
	## Solutions
		Problem.first.solutions << Solution.first
		Problem.find_by_id(2).solutions << Solution.find_by_id(2)
		Problem.find_by_id(3).solutions << Solution.find_by_id(3)
	## Attempts
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
	## Contest Progress
		Cproblem.find_by_id(1).contests_progresses << ContestProgress.first
		Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(2)
		Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(3)
		Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(3)
		Cproblem.find_by_id(4).contests_progresses << ContestProgress.find_by_id(4)
	## Hints
		Problem.first.model_answers.first.hints << Hint.first
		Problem.first.model_answers.first.hints << Hint.all.second

puts("# ----------------------- Tracks ----------------------- ")
	## Problems
		Track.first.problems << Problem.first
		Track.first.problems << Problem.find_by_id(2)
		Track.find_by_id(2).problems << Problem.find_by_id(3)
		Track.find_by_id(2).problems << Problem.find_by_id(4)
		Track.find_by_id(3).problems << Problem.find_by_id(5)

puts("# ----------------------- Topics ----------------------- ")
	## Tracks
		Topic.first.tracks << Track.first
		Topic.first.tracks << Track.find_by_id(2)
		Topic.find_by_id(2).tracks << Track.find_by_id(3)
		Topic.find_by_id(3).tracks << Track.find_by_id(4)

puts("# ----------------------- Courses ----------------------- ")
	## Topics
		Course.first.topics << Topic.first
		Course.first.topics << Topic.find_by_id(2)
		Course.find_by_id(2).topics << Topic.find_by_id(3)
	## Discussion Board
		Course.first.discussion_board = DiscussionBoard.first
		Course.find_by_id(2).discussion_board = DiscussionBoard.find_by_id(2)
		Course.find_by_id(3).discussion_board = DiscussionBoard.find_by_id(3)
		Course.find_by_id(4).discussion_board = DiscussionBoard.find_by_id(4)
		Course.find_by_id(5).discussion_board = DiscussionBoard.find_by_id(5)
		Course.find_by_id(6).discussion_board = DiscussionBoard.find_by_id(6)
		Course.find_by_id(7).discussion_board = DiscussionBoard.find_by_id(7)
	## Course Student	
		Course.first.course_students << CourseStudent.first
	## Assignments
		Course.first.assignments << Assignment.first
		Course.first.assignments << Assignment.find_by_id(2)
		Course.first.assignments << Assignment.find_by_id(4)
		Course.find_by_id(2).assignments << Assignment.find_by_id(3)


puts("# ----------------------- DiscussionBoard ----------------------- ")
	## Posts
		DiscussionBoard.first.posts << Post.first
		DiscussionBoard.first.posts << Post.find_by_id(2)

puts("# ----------------------- Contests ----------------------- ")
	## Problems
		Contest.first.problems << Cproblem.find_by_id(1)
		Contest.first.problems << Cproblem.find_by_id(2)
		Contest.first.problems << Cproblem.find_by_id(3)
		Contest.find_by_id(2).problems << Cproblem.find_by_id(4)
		Contest.find_by_id(3).problems << Cproblem.find_by_id(5)
	## Contests Progress
		Contest.first.progress << ContestProgress.first
		Contest.find_by_id(2).progress << ContestProgress.find_by_id(2)
		Contest.find_by_id(2).progress << ContestProgress.find_by_id(3)
		Contest.find_by_id(3).progress << ContestProgress.find_by_id(4)

puts("# ----------------------- Assignment ----------------------- ")
	## Problems
		Assignment.first.problems << AssignmentProblem.first
		Assignment.first.problems << AssignmentProblem.find_by_id(2)
		Assignment.find_by_id(2).problems << AssignmentProblem.find_by_id(3)
		Assignment.find_by_id(3).problems << AssignmentProblem.find_by_id(4)

puts("# ----------------------- Grades ----------------------- ")
	## Problems
		Grade.first.update(problem_id:Assignment.first.problems.first.id)
		Grade.find_by_id(2).update(problem_id:Assignment.first.problems.find_by_id(2).id)

puts("# --------------------------------------------------------- ")
