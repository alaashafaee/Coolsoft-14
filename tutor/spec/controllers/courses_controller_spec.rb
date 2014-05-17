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
            puts(">>>>>>>>>>>>>>>>>")
            puts(@course.id)
 		end

  		it "shows the grades of the assignments in the course of a the student" do
 			AssignmentsController.skip_before_filter :authenticate!
 			#get :show_grades, id: @course.id
 			#expect(response).to redirect_to("http://test.host/")
			#get :show_grades, :id => @course.id
      		#response.should redirect_to("http://test.host/courses/#{@course.id}/show_grades?")
 			#http://localhost:3000/courses/1/show_grades?
 			#expect(assigns(:course)).to eq(@course)
 			get :show_grades, id: @course.id
 			#response.should have_text("Grades")

 			response.should render_template :
 		end

 	end 
end