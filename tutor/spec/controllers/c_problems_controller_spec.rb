require 'spec_helper'

include Devise::TestHelpers

describe CProblemsController do

	context "Create Contest Problem and deletes it" do
		it "destroys the requested c_problem" do
		lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
			password_confirmation: '123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		Cproblem.create(title: "ContestProblem 1", description: "This is very easy Problem")
		CProblemsController.skip_before_filter :authenticate!
		expect {
			delete :destroy, :id => c_problem.id
		}.to change(Cproblem, :count).by(-1)
		end

	end
end
