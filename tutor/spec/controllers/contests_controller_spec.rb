require 'spec_helper'

describe ContestsController do
	describe "GET show" do

  		

    	it "assigns the requested contest to the @contest" do
    	@contest1 = Contest.new(title: 'TestContest', description: 'Some description')
    	@contest1.save	
    	get :show, id: @contest1.id
    	#assigns(:contest).to eq(@contest1)
    	expect(assigns(:@contest)).to eq(@contest1)
    	end

    	it "render show template" do
    	@contest2 = Contest.new(title: 'TestContest', description: 'Some description')	
		get :show, id: @contest2.id
    	expect(response).to render_template("show")
    	end
    end	
end
