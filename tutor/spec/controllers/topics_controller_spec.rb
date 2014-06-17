require 'spec_helper'

include Devise::TestHelpers

describe TopicsController do

	context "Create Topic and deletes it" do
		it "destroys the requested topic" do
		lecturer = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789', 
			password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		course = Course.create(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", code:"CSEN1",
				link:"http://www.test.org/", year:2014, semester:1)
		topic = Topic.create(title: "Topic1", description: "This is Topic1 description",
		lecturer_id: lecturer.id, course_id: course.id)
		TopicsController.skip_before_filter :authenticate!
		expect {
			delete :destroy, :id => topic.id
		}.to change(Topic, :count).by(-1)
		end

	end
end