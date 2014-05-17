require 'spec_helper'
include Devise::TestHelpers

describe CoursesController do
	describe "POST hide" do
		it "Seen value changes after load" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
 			password_confirmation: '123456789', name: 'LecturerI',
 			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			course = 	Course.new(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course",
				code:"CSEN11", year:2014, semester:1 ,visible: false)
			course.save
			lecturer.courses << course
			sign_in lecturer
			post :hide, :id => lecturer.courses.first.id
			expect(lecturer.courses.first.visible).to be(true)
		end
	end
end