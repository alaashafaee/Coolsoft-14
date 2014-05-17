require 'spec_helper'
include Devise::TestHelpers

describe CoursesController do
	describe "GET create" do
		it "Seen value changes after load" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
 			password_confirmation: '123456789', name: 'LecturerI',
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
 :tags => [1,
 2]
			expect(lecturer.courses.first).to be_an_instance_of Course 
		end
	end
end