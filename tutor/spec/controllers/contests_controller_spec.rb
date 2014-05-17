require 'spec_helper'
include Devise::TestHelpers

describe ContestsController do

	context "CRUD" do 
		it "creates a new contest" do
			#ContestsController.skip_before_filter :authenticate!
			lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
				password_confirmation: '123456789', name: 'LecturerI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			sign_in lecturer
			course = Course.new(name:"Amirooo", 
				code:"tip101", year:2014, semester:1, :description => "hary",
				:link => "http://www.test.org/")
			course.save!
			lecturer.courses << course
			expect{
				get :create, contest: {:title => "Amir contest", :course => "Amirooo",
					:description => "hardest", :start_time => Time.now + 2.days,
					:end_time => Time.now + 3.days}
			}.to change(Contest,:count).by(1)
		end
	end
	xit "returns http success" do
      get 'new'
      expect(response).to be_success
    end

end