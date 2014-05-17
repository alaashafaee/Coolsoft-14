require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCase
include Devise::TestHelpers
end

describe CoursesController do
	describe "GET show" do
		before(:each) do
			sign_out :user
			@course  = Course.create(name:"Data Structures and Alogrithms", 
				description:"This is a very easy course", 
				code:"CSEN1", 
				year:2014, 
				semester:1, 
				link: "http://met.guc.edu.eg/Courses/CourseEdition.aspx?crsEdId=487")
			@student = Student.new(email: '4@student.com', password: '123456789', 
				password_confirmation: '123456789', name: 'StudentIV',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "Fac", university: "Uni", major: "Maj", semester: 8, 
				advising: true, probation: false)
			@student.save!
			@student.courses << @course
		end
	end 
end