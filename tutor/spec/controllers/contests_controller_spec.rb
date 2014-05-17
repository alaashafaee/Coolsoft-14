require 'spec_helper'
include Devise::TestHelpers

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

	context "CRUD" do
		before (:all) do
			@lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789',
				password_confirmation: '123456789', name: 'LecturerI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
			@lecturer.save!
		end

		it "new returns http success" do
			sign_in @lecturer
			get 'new'
			expect(response).to be_success
		end

		it "creates a new contest" do
			sign_in @lecturer
			course = Course.new(name: "Amirooo",
				code: "tip101", year: 2014, semester: 1, :description => "hary",
				:link => "http://www.test.org/")
			course.save!
			@lecturer.courses << course
			expect{
				get :create, contest: {:title => "Amir contest", :course => "Amirooo",
					:description => "hardest", "start_time(1i)" => "2014",
					"start_time(2i)" => "5","start_time(3i)" => "19",
					"start_time(4i)" => "22","start_time(5i)" => "01",
					"end_time(1i)" => "2014","end_time(2i)" => "9",
					"end_time(3i)" => "16","end_time(4i)" => "22",
					"end_time(5i)" => "01",}
			}.to change(Contest,:count).by(1)
		end
	end

	context "Timer" do

		before(:all) do
			Contest.create(title:"Iteration", description:"If you solve this",
				incomplete:false, start_time:DateTime.now+1.minute,
				end_time:DateTime.now+10.minutes, course_id:1,
				owner_id:1, owner_type:"Lecturer")
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

	end

end
