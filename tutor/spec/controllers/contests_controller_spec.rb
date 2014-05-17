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

	before(:all) do
		Contest.create(title:"Iteration", description:"If you can solve this you will get a level up",
			incomplete:false, start_time:DateTime.now+1.minute, end_time:DateTime.now+10.minutes, 
			course_id:1, owner_id:1, owner_type:"Lecturer")
		@c = Contest.first
	end

	before(:each) do
		controller.class.skip_before_action :authenticate!
		get 'show', {:id => '1'}
	end

	context "Contest hasn't started yet" do
		before(:all) do
			@c.start_time = DateTime.now + 10.minutes
			@c.end_time = @c.start_time + 10.minutes
			@c.save
		end

		it "checks the timer variable" do
			expect(assigns(:timer).to_i).to eq @c.start_time.to_i
		end

		it "checks the message variable" do
			expect(assigns(:message)).to eq "Contest starts in"
		end

		it "checks the del variable" do
			expect(assigns(:del)).to eq false
		end
	end

	context "Contest has already started" do
		before(:all) do
			@c.start_time = DateTime.now + 1.second
			@c.end_time = @c.start_time + 20.minutes
			@c.save
			sleep 2
		end

		it "checks the timer variable" do
			expect(assigns(:timer).to_i).to eq @c.end_time.to_i
		end

		it "checks the message variable" do
			expect(assigns(:message)).to eq "Contest ends in"
		end

		it "checks the del variable" do
			expect(assigns(:del)).to eq false
		end
	end

	context "Contest has ended" do
		before(:all) do
			@c.start_time = DateTime.now + 1.second
			@c.end_time = @c.start_time + 1.second
			@c.save
			sleep 3
		end

		it "checks the timer variable" do
			expect(assigns(:timer).to_i).to eq 0
		end

		it "checks the message variable" do
			expect(assigns(:message)).to eq "Contest has finished!"
		end

		it "checks the del variable" do
			expect(assigns(:del)).to eq true
		end
	end

>>>>>>> 409c730358745f49f6f0886d3effa9179ed46d8f
end
