require 'spec_helper'
include Devise::TestHelpers

describe ContestsController do

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

	context "CRUD" do
		it "creates a new contest" do
			sign_in @lecturer
			course = Course.new(name:"Amirooo",
				code:"tip101", year:2014, semester:1, :description => "hary",
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

end