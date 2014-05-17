require 'spec_helper'

describe CProblemsController do
	include Devise::TestHelpers
	render_views

	let :my_lecturer do
		lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		lecturer
	end

	let :bad_title do
		cprob = Cproblem.new
		cprob.title = ""
		cprob.description = "I don't have a title"
		cprob.time_limit = 42
		cprob.owner_id = 1
		cprob.owner_type = 'lecturer'
		cprob
	end

	let :bad_description do
		cprob = Cproblem.new
		cprob.title = "I don't have a description"
		cprob.description = ""
		cprob.time_limit = 42
		cprob.owner_id = 1
		cprob.owner_type = 'lecturer'
		cprob
	end

	let :bad_time_limit do
		cprob = Cproblem.new
		cprob.title = "What am I missing?"
		cprob.description = "The proper time"
		cprob.time_limit = ""
		cprob.owner_id = 1
		cprob.owner_type = 'lecturer'
		cprob
	end

	let :good_problem do
		cprob = Cproblem.new
		cprob.title = "What's wrong with me?"
		cprob.description = "Absolutely nothing."
		cprob.time_limit = 123
		cprob.owner_id = 1
		cprob.owner_type = 'lecturer'
		cprob
	end

	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:lecturer]
		sign_in my_lecturer
		expect(subject.current_lecturer).to_not be_nil
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
			good_problem
			post :create, cproblem: good_problem

			render
			expect(rendered).to contain("Your contest problem has been created.")
		end

		it "rejects blank problem titles" do
			bad_title
			post :create, cproblem: bad_title
			expect(response.body).to match /blank title./m
		end

		it "rejects blank problem descriptions" do
			bad_description
			post :create, cproblem: bad_description
			expect(response.body).to match /blank description./m
		end

		it "rejects invalid problem time limits" do
			bad_time_limit
			post :create, cproblem: bad_time_limit
			expect(response.body).to match /time limit must be a numeric value greater than zero./m
		end

	end
end
