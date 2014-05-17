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
	context "Create Problem and deletes it" do
			it "create, edit and destroy the requested problem" do
				lecturer = Lecturer.create(name: "sameh", gender: true, degree: "PhD",
					department: "MET", university: "GUC", email: "1@tas.com",
					encrypted_password: "string",
					reset_password_token: "string",
					confirmation_token: "true")
					course = Course.create(name:"Data Structures and Alogrithms", 
					description:"This is a very easy course", code:"CSEN1", year:2014, semester:1)
				topic = Topic.create(title: "string", description: "text", order_factor: 1, course_id: course.id,
				 lecturer_id: 1)
				track = Track.create(title: "string_track", difficulty: 3, views_count: 2,
				 topic_id: 1, owner_id: 1, owner_type: "lecturer")
				problem = Problem.create(title: "problem example 6", description: "description here",
					snippet: "snippet here", views_count: "3", time_limit: "30",
					track_id: track.id, fill_gaps: false, incomplete: true, seen: true, duplicated: false,
					owner_id: lecturer.id, owner_type: "Lecturer")
				ProblemsController.skip_before_filter :authenticate!
				expect(Problem.where(id: problem.id)).to exist

				expect{
					problem.update_attributes(title: "problem edit")
					problem.reload
				}.to change{problem.title}.from("problem example 6").to("problem edit")
				
				expect {
					delete :destroy, :problem_id => problem.id
				}.to change(Problem, :count).by(-1)
			
				expect{
					get :create, :problem => {title: "problem exampse 6", description: "descriwption here",
					snippet: "snippewt here", views_count: "33", time_limit: "10",
					track_id: track.id, fill_gaps: false, incomplete: true, seen: true, duplicated: false,
					owner_id: lecturer.id, owner_type: "Lecturer"}, :track_id => track.id
				}.to change(Problem,:count).by(+1)
			end
		end			
end