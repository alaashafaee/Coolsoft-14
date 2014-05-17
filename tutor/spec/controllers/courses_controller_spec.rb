require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCase
include Devise::TestHelpers
end

describe CoursesController do
 	
 	describe "GET show" do
 		before(:each) do
 			sign_out :user
 			#@course = Course.create(name: "Test Course",
 			#code: "Assignment1 description", year: 123, semester: 1, university: "UNI",
 			#description: "DESC", visible: true, incomplete: false)
			puts(">>>>>>>>>>>>")
            @course  = Course.find_by_id(1)
 		end

  		it "shows the grade of the assignments in the course of a the student" do
 			AssignmentsController.skip_before_filter :authenticate!
 			get :show_grades, id: @course.id
 			expect(assigns(:course)).to eq(@course)
 		end

 	end 
end