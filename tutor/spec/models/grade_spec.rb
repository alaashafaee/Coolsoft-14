require 'spec_helper'

describe Note do
	it 'is valid with a grade, student_id and problem_id' do
		grade = Grade.new(
			grade: 10,
			student_id: 1,
			problem_id: 1)
		grade.save
		expect(grade).to be_valid
	end

	it 'is invalid without a grade' do
		grade = Grade.new(
			student_id: 1,
			problem_id: 1)
		grade.save
		expect(grade).not_to be_valid
	end

	it 'is invalid without student_id' do
		grade = Grade.new(
			grade: 10,
			problem_id: 1)
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
		grade = Grade.new(
			grade: 10,
			student_id: 1,
			problem_id: 1)
		expect {grade.save}.to change {Grade.count}.by(1)
	end
end