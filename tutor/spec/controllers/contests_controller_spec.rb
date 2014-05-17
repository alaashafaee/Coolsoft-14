require 'spec_helper'
include Devise::TestHelpers

describe ContestsController do

	before(:each) do
		request.env["HTTP_REFERER"] = "where_i_came_from"
	end

	before (:all) do
		@lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789',
				password_confirmation: '123456789', name: 'LecturerI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
		@lecturer.save!
		course = Course.create(name:"DSA", description:"good",
			code:"CSEN1", link:"http://www.test.org/", year:2014, semester:1)
		course.save!
		@contest = Contest.new(title:"Iteration", description:"If you",
		incomplete:false, start_time:Time.now+2.days, end_time:Time.now+7.days)
		@contest.save!
		course.contests << @contest
		@lecturer.contests << @contest
		@problem = Cproblem.new(title: "cp1", description: "nice")
		@problem.save!
		@contest.problems << @problem
	end

	it "add_problems returns http success" do
		sign_in @lecturer
		get 'add_problems', :id => @contest.id.to_s
		expect(response).to be_success
	end

	it "adds a new problem to the contest" do
		sign_in @lecturer
		problem2 = Cproblem.new(title: "cp2", description: "very nice")
		problem2.save!
		expect{
			get :add,  {:id => @contest.id, :problem_id => problem2.id}
		}.to change(@contest.problems,:count).by(1)
	end

end