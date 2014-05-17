require 'spec_helper'

describe AssignmentsController do
  include Devise::TestHelpers


describe "#new" do
    it "takes three parameters and returns a Book object" do
        @new_assignment.should be_an_instance_of Assignment
    end
end
describe "GET #create" do
    context "with valid attributes" do
      it "saves the new tag in the database" do
        expect{
          get :create, assignment: {:title => 'Software',:description =>'dssd'}
        }.to change(Assignment,:count).by(1)
      end
    end
  

  end
    context "with valid attributes " do
    it "creates a new comment" do
      i = Course.new
      i.name="Data Structures and Alogrithms"
       i.description="This is a very easy course" 
       i.code="CSEN1"
       i.year=2014
        i.semester=1
        i.save

      expect{
        post :create, :course_id => i.id
      }.to change(Assignment,:count).by(1)
    end
  end

end
