require 'spec_helper'
include Warden::Test::Helpers
include Devise::TestHelpers

class ActiveSupport::TestCase
	include Devise::TestHelpers
end

describe ProblemsController do
	before :each do
		sign_out :user
	end
	before (:all) do 
		@lecturer = Lecturer.new(email: '1@lecturer.com', 
			password: 'Aa123456789', password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now,
			dob: DateTime.now.to_date, gender: true, degree: "PhD", university: "GUC", department: "MET")
	end

	context "Create Problem and deletes it" do
		it "create and destroy the requested problem" do
			sign_in @lecturer 
			lecturer = Lecturer.create(name: "sameh", gender: true, degree: "PhD",
				department: "MET", university: "GUC", email: "1@tas.com",
				encrypted_password: "string",
				reset_password_token: "string",
				confirmation_token: "true")
			course = Course.create(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", code:"CSEN1", year:2014, semester:1)
			topic = Topic.create(title: "string", description: "text", order_factor: 1,
			course_id: course.id, lecturer_id: 1)
			track = Track.create(title: "string_track", difficulty: 3, views_count: 2,
				 topic_id: 1, owner_id: 1, owner_type: "lecturer")
			problem = Problem.create(title: "problem example 6", description: "description here",
				snippet: "snippet here", views_count: "3", time_limit: "30",
				track_id: track.id, fill_gaps: false, incomplete: true, seen: true, duplicated: false,
				owner_id: lecturer.id, owner_type: "Lecturer")
			ProblemsController.skip_before_filter :authenticate!
			expect(Problem.where(id: problem.id)).to exist

			expect{
				get :create, problem: {title: "problem rspec test", description: "description here",
				snippet: "snippet here" }, :track_id => 1 , :flag => 0
			}.to change(Problem, :count).by(+1)

			expect {
				delete :destroy, :problem_id => problem.id
			}.to change(Problem, :count).by(-1)
		end
	end

end