require 'spec_helper'

describe ContestsController do
	describe "GET show" do
        before(:each) do
            @contest1 = Contest.create(title: 'TestContest', description: 'Some description')
        end

      	it "assigns the requested contest to the @contest" do
            ContestsController.skip_before_filter :authenticate!
        	get :show, id: @contest1.id
        	expect(assigns(:contest)).to eq(@contest1)
        end

        	it "render show template" do
            ContestsController.skip_before_filter :authenticate!	
    		get :show, id: @contest1.id
        	expect(response).to render_template("show")
        end
    end	
end
