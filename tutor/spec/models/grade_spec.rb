require 'spec_helper'

describe Grade do
	it 'is valid with a grade, student_id and problem_id' do
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			grade: 10,
			student_id: 1,
			problem_id: problem.id)
		grade.save
		expect(grade).to be_valid
	end

	it 'is invalid without a grade' do
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			student_id: 1,
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
		grade = Grade.new(
			grade: 10,
			student_id: 1)
		grade.save
		expect(grade).not_to be_valid
	end

	it 'Changes the number of grades' do
		problem = AssignmentProblem.new(title: "AssignmentProblem 1",
			description: "long description", final_grade: 100)
		problem.save
		grade = Grade.new(
			grade: 10,
			student_id: 1,
			problem_id: problem.id)
		expect {grade.save}.to change {Grade.count}.by(1)
	end
end