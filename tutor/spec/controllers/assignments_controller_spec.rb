require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::Assignment
	include Devise::TestHelpers
end

describe AssignmentsController do
	before (:all) do
		@course = Course.new(name:"SE2",
			code:"Se2", year:2014, semester:6, :description => "last sprint",
			:link => "http://met.guc.edu.eg/")
		@course.save!
	end
	
	context "Delete" do
		it "destroy the requested assignment" do
			AssignmentsController.skip_before_filter :authenticate!
			assignment = Assignment.new(title: "assignmentdelete",
				description: "will be deleted", course_id: @course.id)
			assignment.save!
			expect {
				delete :destroy, :id => assignment.id
			}.to change(Assignment, :count).by(-1)
		end
	end
	context "edit" do
		it "edit the requested assignment" do
			AssignmentsController.skip_before_filter :authenticate!
			@assignment = Assignment.new(title: "assignmentdelete1",
				description: "will be deleted", course_id: @course.id)
			@assignment.save!
			expect{
				put :update, assignment: {
					:description => "try to solve1"},:id => @assignment.id
				@assignment.reload
			}.to change{@assignment.description}.from("will be deleted").to("try to solve1") 
		end
		it "edit the requested assignment invalid as title can not be empty" do
			AssignmentsController.skip_before_filter :authenticate!
			@assignment = Assignment.new(title: "assignmentdelete2",
				description: "will be deleted", course_id: @course.id)
			@assignment.save!
			put :update, assignment: {
				:title => ""},:id => @assignment.id
				@assignment.reload
			@assignment.title.should eq("assignmentdelete2")
		end
	end
end