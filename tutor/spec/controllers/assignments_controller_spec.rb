require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCase
include Devise::TestHelpers
end

describe AssignmentsController do


  before(:each) do
    sign_out :user
  end
describe "#new" do
 
end
describe "POST #create" do

 it "saves the new tag in the database" do
        expect{
          post :create, assignment: {:title => 'Software',:description =>'dssd'}
        }.to change(Assignment,:count).by(1)
      end
       before(:each) do
    sign_out :user
  end
  
    it "takes three parameters and returns a Book object" do
        @new_assignment.should be_an_instance_of Assignment
    end
    end
  

    

end
