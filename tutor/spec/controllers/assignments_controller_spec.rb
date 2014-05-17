require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::Assignment
	include Devise::TestHelpers
end

describe AssignmentsController do
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
	end
	
	context "Delete" do
		it "destroy the requested assignment" do
			AssignmentsController.skip_before_filter :authenticate!
			assignment = Assignment.new(title: "assignmentdelete",
				description: "will be deleted", course_id: @course.id)
			expect {
				delete :delete, :id => assignment.id
			}.to change(Assignment, :count).by(-1)
		end
	end
end