require 'spec_helper'

describe AssignmentsController do
 	
 	describe "GET show" do
 		before(:each) do
 			@assignment1 = Assignment.create(title: 'Test Assignment', description: 'Math Assignment') 			
 		end
 
 		it "assigns the requested assignment to the @assignment1" do
 			AssignmentsController.skip_before_filter :authenticate!
 			get :show, id: @assignment1.id
 			expect(assigns(:assignment1)).to(@assignment1)
 		end
 	end
 	
end