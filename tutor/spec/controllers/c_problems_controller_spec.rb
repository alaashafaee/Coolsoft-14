require 'spec_helper'

<<<<<<< HEAD
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

=======
describe CProblemsController do
	include Devise::TestHelpers

	before(:each) do
		controller.class.skip_before_action :authenticate!
	end

	after(:each) do
		expect(response).to be_success
	end

	describe "GET new" do
		it "renders the contest problem creation form" do
			get :new
			expect(flash[:notice]).to be_nil
		end
	end

	describe "POST create" do
		it "creates a new contest problem" do
			expect {
				post :create, cproblem: {title: "Test", description: "Test", time_limit: 20}
			}.to change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects blank problem titles" do
			expect {
				post :create, cproblem: {title: "", description: "Test", time_limit: 20}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects blank problem descriptions" do
			expect {
				post :create, cproblem: {title: "Test", description: "", time_limit: 20}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end

		it "rejects invalid problem time limits" do
			expect {
				post :create, cproblem: {title: "Test", description: "Test", time_limit: "lol"}
			}.to_not change(Cproblem, :count)
			expect(flash[:notice]).to_not be_nil
		end
>>>>>>> 1fd672d502cc781d042233b6f2a6e997e12349ca
	end
end
