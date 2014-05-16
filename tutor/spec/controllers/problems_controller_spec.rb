require 'spec_helper'
include Warden::Test::Helpers
include Devise::TestHelpers



describe ProblemsController do


			context "Create Problem and deletes it" do
		it "create, edit and destroy the requested problem" do
			lecturer = Lecturer.find_by_id(1)
			lecturer.save!
			course = Course.find_by_id(1)
			topic = Topic.find_by_id(1)
			track = Track.find_by_id(1)
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
		
		expect {

      				@problem1 = { title: "problem example 213", description: "description here",
      				 snippet: "snippet here", views_count: "3", time_limit: "30", track_id: track.id,
      				  fill_gaps: false, incomplete: true,
        			seen: true, duplicated: false, owner_id: lecturer.id, owner_type: "Lecturer" }
			:new, :track_id => track.id
	         	   

	        }.to change(Problem, :count).by(1)
	  end

        end			
	    


end