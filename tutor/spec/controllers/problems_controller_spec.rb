require 'spec_helper'
include Warden::Test::Helpers
include Devise::TestHelpers

describe ProblemsController do

	context "Create Problem and deletes it" do
		it "create, edit and destroy the requested problem" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
				password_confirmation: '123456789', name: 'LecturerI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			course = Course.create(name:"Data Structures and Alogrithms", 
					description:"This is a very easy course", code:"CSEN1", year:2014, semester:1)
			topic = Topic.create(title: "Topic1", description: "This is Topic1 description",
			lecturer_id: lecturer.id, course_id: course.id)
			track = Track.create(title: "track1", difficulty: "3", views_count: "1", topic_id: topic.id, owner_type: "Lecturer",
			owner_id: lecturer.id)
			problem = Problem.create(title: "problem example 2", description: "description here", snippet: "snippet here", views_count: "3", time_limit: "30", track_id: track.id, fill_gaps: false, incomplete: true, seen: true, duplicated: false, owner_id: lecturer.id, owner_type: "Lecturer")
			ProblemsController.skip_before_filter :authenticate!
			expect(Problem.where(id: problem.id)).to exist
			
			expect{
				problem.update_attributes(title: "problem edit")
				problem.reload
			}.to change{problem.title}.from("problem example 2").to("problem edit")
			
			expect {
				delete :destroy, :problem_id => problem.id
			}.to change(Problem, :count).by(-1)
		end
	end
end