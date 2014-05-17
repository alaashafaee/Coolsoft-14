require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::AssignmentProblem
	include Devise::TestHelpers
end

describe AssignmentProblemsController do
	before (:all) do
		@lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789',
			password_confirmation: '123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
		@lecturer.save!
		@course = Course.new(name:"SE2",
			code:"Se2", year:2014, semester:6, :description => "last sprint",
			:link => "http://met.guc.edu.eg/")
		@course.save!
		@assignment = Assignment.new(title: "assignmentdelete",
			description: "will be deleted", course_id: @course.id)
		@assignment.save!
	end
	
	context "Delete" do
		it "destroy the requested assignment" do
			AssignmentProblemsController.skip_before_filter :authenticate!
			@assignment_problem = AssignmentProblem.new(title: "assignmentpdelete",
			description: "will be deleted", assignment_id: @assignment.id)
			@assignment_problem.save!

			expect {
				delete :destroy, :id => @assignment_problem.id
			}.to change(AssignmentProblem, :count).by(-1)
		end
	end
end