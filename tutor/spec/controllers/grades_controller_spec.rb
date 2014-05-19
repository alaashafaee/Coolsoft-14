require 'spec_helper'

describe GradesController do

	context "Create grade and update it" do
		it "updates the requested grade" do
			student = Student.new(email: '1@student.com', password: 'Aa123456789',
			password_confirmation: 'Aa123456789', name: 'StudentI',
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
			GradesController.skip_before_filter :authenticate!
			grade.update_attributes(grade: 80, student_id: student.id,
				problem_id: problem.id)
			grade.grade.should eq 80
		end
	end

	context "Viewing all grades" do
		it "grades hash is updated with student's grade" do
			student = Student.new(email: '1@student.com', password: 'Aa123456789',
			password_confirmation: 'Aa123456789', name: 'StudentI',
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
			GradesController.skip_before_filter :authenticate!
			@grades = Hash.new
			grade = Grade.where(problem_id: problem.id,
				student_id: student.id).first
			@grades[1] = grade.grade
			@grades[1].should eq 10
		end
	end

end
