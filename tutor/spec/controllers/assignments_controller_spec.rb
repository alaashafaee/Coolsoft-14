require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCase
include Devise::TestHelpers
end

describe AssignmentsController do


  before(:each) do
    sign_out :user
  end

 it "saves the new tag in the database" do
  lecturer = Lecturer.create(name: "sameh", gender: true, degree: "PhD",
          department: "MET", university: "GUC", email: "1@tas.com",
          encrypted_password: "string",
          reset_password_token: "string",
          confirmation_token: "true")
          course = Course.create(name:"Data Structures and Alogrithms", 
          description:"This is a very easy course", code:"CSEN1", year:2014, semester:1)
  
       AssignmentController.skip_before_filter :authenticate!
    
        expect{
          get :create, assignment=> {title:'Software',description:'dssd'},:course_id=>course.id
        }.to change(Assignment,:count).by(+1)
      end


    it "takes three parameters and returns a Book object" do
        @new_assignment.should be_an_instance_of Assignment
    end
    end
  

    

end
