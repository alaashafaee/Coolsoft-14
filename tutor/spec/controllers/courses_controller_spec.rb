require 'spec_helper'
include Devise::TestHelpers

describe CoursesController do
	describe "GET create" do
		it "Seen value changes after load" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789', 
 			password_confirmation: 'Aa123456789', name: 'LecturerI',
 			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			sign_in lecturer
			get :new 
			get :create, :course =>{:name =>'adssa',
			:code =>'121',
			:description => 'fdsa',
			:link =>'http://www.amgad.com',
			:semester =>123,
			:year => 132312},
			:tags => [1,2]
			expect(lecturer.courses.first).to be_an_instance_of Course
		end 
	end
	describe "POST hide" do
		it "Seen value changes after load" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789', 
			password_confirmation: 'Aa123456789', name: 'LecturerI',
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
		it "Seen value changes" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789', 
			password_confirmation: 'Aa123456789', name: 'LecturerI',
			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			course = 	Course.new(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course",
				code:"CSEN11", year:2014, semester:1 ,visible: true)
			course.save
			lecturer.courses << course
			sign_in lecturer
			post :hide, :id => lecturer.courses.first.id
			expect(lecturer.courses.first.visible).to be(false)
		end
	end
end
