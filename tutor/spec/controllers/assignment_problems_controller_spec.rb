require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::AssignmentProblem
	include Devise::TestHelpers
end

describe AssignmentProblemsController do
	before (:all) do
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
	context "edit" do
		it ":edit the requested problem" do
			AssignmentProblemsController.skip_before_filter :authenticate!
			@assignmentp = AssignmentProblem.new(title: "assignmentpdelete1",
				description: "will be deleted", assignment_id: @assignment.id)
			@assignmentp.save!
			expect{
				put :update, assignment_problem: {
					:description => "try to solve1"},:id => @assignmentp.id
				@assignmentp.reload
			}.to change{@assignmentp.description}.from("will be deleted").to("try to solve1") 
		end
		it ":edit the requested assignment invalid as title can not be empty" do
			AssignmentProblemsController.skip_before_filter :authenticate!
			@assignmentp = AssignmentProblem.new(title: "assignmentdelete2",
				description: "will be deleted", assignment_id: @assignment.id)
			@assignmentp.save!
			put :update, assignment_problem: {
				:title => ""},:id => @assignmentp.id
				@assignmentp.reload
			@assignmentp.title.should eq("assignmentdelete2")
		end
			it ":edit the requested assignment invalid as description can not be empty" do
			AssignmentProblemsController.skip_before_filter :authenticate!
			@assignmentp = AssignmentProblem.new(title: "assignmentdelete2",
				description: "will be deleted", assignment_id: @assignment.id)
			@assignmentp.save!
			put :update, assignment_problem: {
				:description => ""},:id => @assignmentp.id
				@assignmentp.reload
			@assignmentp.description.should eq("will be deleted")
		end
	end
end