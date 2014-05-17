require 'spec_helper'
include Devise::TestHelpers
class ActiveSupport::TestCase
include Devise::TestHelpers
end

describe AssignmentsController do
 	
 	describe "GET show" do
 		before(:each) do
 			sign_out :user
 			@assignment = Assignment.create(title: "Assignment 1", description: "Assignment1 description")
 		end

  		it "assigns the requested assignment to the @assignment" do
 			AssignmentsController.skip_before_filter :authenticate!
 			get :show, id: @assignment.id
 			expect(assigns(:assignment)).to eq(@assignment)
 		end

  		it "shows the ta's correction to a particular assignment" do 			
 			AssignmentsController.skip_before_filter :authenticate!
 			get :show_correction, id: @assignment.id
 			expect(assigns(:assignment)).to eq(@assignment)
 		end
 	end 
end