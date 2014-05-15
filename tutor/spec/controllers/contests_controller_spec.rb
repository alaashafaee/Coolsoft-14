require 'spec_helper'
include Devise::TestHelpers

describe ContestsController do
	describe "GET index" do
		it "renders the index template" do
			lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
 			password_confirmation: '123456789', name: 'LecturerI',
 			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", university: "GUC", department: "MET")
			lecturer.save!
			sign_in lecturer
			get :index
			expect(response).to render_template("index")
		end
		it "renders the index template" do
			student = Student.new(email: '1@lecturer.com', password: '123456789', 
 			password_confirmation: '123456789', name: 'LecturerI',
 			confirmed_at: Time.now, dob: DateTime.now.to_date, 
 			gender: true,university: "GUC", faculty: "Engineering", semester: 6,major: "alwan")
			student.save!
			sign_in student
			get :index
			expect(response).to render_template("index")
		end
		it "renders the index template" do
			teaching_assistant = TeachingAssistant.new(email: '1@lecturer.com', password: '123456789', 
 			password_confirmation: '123456789', name: 'LecturerI',
 			confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
			degree: "PhD", graduated_from: "GUC", department: "MET", university: "GUC", graduated_year: 2005)
			teaching_assistant.save!
			sign_in teaching_assistant
			get :index
			expect(response).to render_template("index")
		end
	end
end
