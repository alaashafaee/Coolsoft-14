require 'spec_helper'

describe Note do
	it 'is valid with a grade, student_id and problem_id' do
		student = Student.new(email: '1@student.com', password: '123456789',
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6,
		advising: false, probation: false)
		student.save
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			grade: 10,
			student_id: student.id,
			problem_id: problem.id)
		grade.save
		expect(grade).to be_valid
	end

	it 'is invalid without a grade' do
		student = Student.new(email: '1@student.com', password: '123456789',
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6,
		advising: false, probation: false)
		student.save
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			student_id: student.id,
			problem_id: problem.id)
		grade.save
		expect(grade).not_to be_valid
	end

	it 'is invalid without student_id' do
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			grade: 10,
			problem_id: problem.id)
		grade.save
		expect(grade).not_to be_valid
	end

	it 'is invalid without problem_id' do
		student = Student.new(email: '1@student.com', password: '123456789',
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6,
		advising: false, probation: false)
		student.save
		grade = Grade.new(
			grade: 10,
			student_id: student.id)
		grade.save
		expect(grade).not_to be_valid
	end

	it 'Changes the number of grades' do
		student = Student.new(email: '1@student.com', password: '123456789',
		password_confirmation: '123456789', name: 'StudentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		faculty: "MET", university: "GUC", major: "CS", semester: 6,
		advising: false, probation: false)
		student.save
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			grade: 10,
			student_id: student.id,
			problem_id: problem.id)
		expect {grade.save}.to change {Grade.count}.by(1)
	end
end