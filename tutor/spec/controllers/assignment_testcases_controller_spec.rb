require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCaseProblem
	include Devise::TestHelpers
end

describe AssignmentTestcasesController do
	before (:all) do
		@lecturer = Lecturer.new(email: '51@lecturer.com', password: 'Aa123456789',
			password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
		@lecturer.save!
		@aproblem = AssignmentProblem.new(title: 'assignmentproblem', description: 'testcase for problem')
		@aproblem.save!
	end
	context "CREATE" do
		it "creates a new testcase for problem" do
		sign_in @lecturer
		expect{
			get :create, new_test_case: {:input => "Assignmentproblemse2",
				:output => "try to solve" ,
				:problem_id => @aproblem.id}
	  		}.to change(TestCase,:count).by(1)
		end
		it 'is invalid testcase without input' do
	 		sign_in @lecturer
	  		expect{
				get :create, new_test_case: {
					:output => "try to solve" ,
					:problem_id => @aproblem.id}
	  		}.to change(TestCase,:count).by(0)
		end
		it 'is invalid testcase without output' do
	  		sign_in @lecturer
	  		expect{
			get :create, new_test_case: {:input => "Assignmentproblemse2",
				:problem_id => @aproblem.id}
	  	}.to change(AssignmentProblem,:count).by(0)
	end
  end
end