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
Lecturer.create!(name:"Lecturer1" , email:"1@lecturer.com" , password:"123456789")
Lecturer.create!(name:"Lecturer1" , email:"2@lecturer.com" , password:"123456789")

puts("# ---------------------------Students-----------------------------")
Student.create!(name:"Student1" , email:"1@student.com" , password:"123456789")
Student.create!(name:"Student2" , email:"2@student.com" , password:"123456789")

puts("# ---------------------------TeachingAssistants-----------------------------")
TeachingAssistant.create(name:"TA1" , email:"1@ta.com" , password:"123456789")
TeachingAssistant.create(name:"TA2" , email:"2@ta.com" , password:"123456789")

puts("# --------------------------Courses------------------------------")
Course.create(name:"Course1", description:"This is course one", code:1, year:2014, semester:1)
Course.create(name:"Course2", description:"This is course two", code:2, year:2014, semester:1)
Course.create(name:"Course3", description:"This is course three", code:3, year:2014, semester:1)

puts("# --------------------------DiscussionBoards------------------------------")
DiscussionBoard.create(title:"DiscussionBoard1", activated: true)
DiscussionBoard.create(title:"DiscussionBoard2", activated: true)
DiscussionBoard.create(title:"DiscussionBoard3", activated: true)

puts("# --------------------------Posts------------------------------")
Post.create(content: "Post1")
Post.create(content: "Post2")
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
TestCase.create(output: "hello World 1" , input:"x = 0")
TestCase.create(output: "hello World 2" , input:"x = 1")
TestCase.create(output: "hello World 3" , input:"x = 2")

puts("# -----------------------Method Parameters---------------------------")
MethodParameter.create(parameter:"MethodParameters 1")
MethodParameter.create(parameter:"MethodParameters 2")
MethodParameter.create(parameter:"MethodParameters 3")

puts("# -----------------------Variable Constraints---------------------------")
VariableConstraint.create(variable_name: "VariableConstraint 1")
VariableConstraint.create(variable_name: "VariableConstraint 2")
VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# -----------------------Problems---------------------------")
Problem.create(title:"Problem 1" , description:"This will be very hard Problem")
Problem.create(title:"Problem 2" , description:"This is very hard Problem")
Problem.create(title:"Problem 3" , description:"This wont be a hard Problem")

puts("# -----------------------Tracks---------------------------")
Track.create(title: "Track 1" , difficulty: 1)
Track.create(title: "Track 2" , difficulty: 2)
Track.create(title: "Track 3" , difficulty: 3)

puts("# -----------------------Solutions---------------------------")
Solution.create(code:"println(My first solution)",length:5,status:3)
Solution.create(code:"println(My second solution)",length:5,status:3)
Solution.create(code:"println(My third solution)",length:5,status:3)

puts("# -------------------------------------------------------")

puts("**************************************************************")
puts("                      Creating Relations                    ")
puts("**************************************************************")

puts("# -----------------------Users---------------------------")
Lecturer.first.topics << Topic.first
Lecturer.first.tracks << Track.first
Lecturer.first.problems << Problem.first
Lecturer.first.courses << Course.first
Lecturer.first.courses << Course.find_by_id(2)

puts("# -----------------------Problems---------------------------")
Problem.first.model_answers << ModelAnswer.first
Problem.first.model_answers << ModelAnswer.find_by_id(2)
Problem.first.test_cases << TestCase.first
Problem.first.solutions << Solution.first

Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(3)
Problem.find_by_id(2).model_answers << ModelAnswer.find_by_id(4)
Problem.find_by_id(2).test_cases << TestCase.first
Problem.find_by_id(2).solutions << Solution.find_by_id(2)

Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(5)
Problem.find_by_id(3).model_answers << ModelAnswer.find_by_id(6)
Problem.find_by_id(3).test_cases << TestCase.first
Problem.find_by_id(3).solutions << Solution.find_by_id(3)

puts("# -----------------------Tracks---------------------------")
Track.first.problems << Problem.first
Track.find_by_id(2).problems << Problem.find_by_id(2)
Track.find_by_id(3).problems << Problem.find_by_id(3)

puts("# -----------------------Topics---------------------------")
Topic.first.tracks << Track.first
Topic.find_by_id(2).tracks << Track.find_by_id(2)
Topic.find_by_id(3).tracks << Track.find_by_id(3)

puts("# -----------------------Courses---------------------------")
Course.first.topics << Topic.first
Course.first.discussion_board = DiscussionBoard.first
Course.first.topics << Topic.find_by_id(2)
Course.find_by_id(2).topics << Topic.find_by_id(3)
Course.find_by_id(2).discussion_board = DiscussionBoard.last

puts("# -------------------------------------------------------")