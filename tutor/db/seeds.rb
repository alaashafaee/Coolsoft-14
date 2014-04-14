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
Lecturer.create(name: "Lecturer1")
Lecturer.create(name: "Lecturer2")

puts("# ---------------------------Students-----------------------------")
Student.create(name: "Student1")
Student.create(name: "Student2")

puts("# ---------------------------TeachingAssistants-----------------------------")
TeachingAssistant.create(name: "TA1")
TeachingAssistant.create(name: "TA2")

puts("# --------------------------Courses------------------------------")
Course.create(name:"Course1")
Course.create(name:"Course2")
Course.create(name:"Course3")

puts("# --------------------------DiscussionBoards------------------------------")
DiscussionBoard.create(title:"DiscussionBoard1")
DiscussionBoard.create(title:"DiscussionBoard2")
DiscussionBoard.create(title:"DiscussionBoard3")

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
Topic.create(title: "Topic1")
Topic.create(title: "Topic2")
Topic.create(title: "Topic3")

puts("# -----------------------Hints---------------------------")
Hint.create(message: "Do not Try to Solve CS problem-1")
Hint.create(message: "Do not Try to Solve CS problem-2")
Hint.create(message: "Do not Try to Solve CS problem-3")

puts("# -----------------------ModelAnswer---------------------------")
ModelAnswer.create(answer: "System.out.println('SQL baaaad')-1")
ModelAnswer.create(answer: "System.out.println('SQL baaaad')-2")
ModelAnswer.create(answer: "System.out.println('SQL baaaad')-3")

puts("# -----------------------Test Cases---------------------------")
TestCase.create(output: "hello World 1")
TestCase.create(output: "hello World 2")
TestCase.create(output: "hello World 3")

puts("# -----------------------Method Parameters---------------------------")
MethodParameter.create(parameter:"MethodParameters 1")
MethodParameter.create(parameter:"MethodParameters 2")
MethodParameter.create(parameter:"MethodParameters 3")

puts("# -----------------------Variable Constraints---------------------------")
VariableConstraint.create(variable_name: "VariableConstraint 1")
VariableConstraint.create(variable_name: "VariableConstraint 2")
VariableConstraint.create(variable_name: "VariableConstraint 3")

puts("# -----------------------Problems---------------------------")
Problem.create(title:"Problem 1")
Problem.create(title:"Problem 2")
Problem.create(title:"Problem 3")

puts("# -----------------------Tracks---------------------------")
Track.create(title: "Track 1")
Track.create(title: "Track 2")
Track.create(title: "Track 3")

puts("# -------------------------------------------------------")
