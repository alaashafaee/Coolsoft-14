require 'spec_helper'
include Devise::TestHelpers

describe ProblemBankController do
	it 'Shows the problem bank for lecturer' do
		lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		sign_in lecturer
		get :show
		expect(response).to render_template("show")
	end
	it 'Shows the problem bank for TA' do
		teaching_assistant = TeachingAssistant.new(email: '1@ta.com', password: '123456789', 
		password_confirmation: '123456789', name: 'taI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", graduated_from: "GUC", department: "MET", university: "GUC", 
		graduated_year: 2005)
		teaching_assistant.save!
		sign_in teaching_assistant
		get :show
		expect(response).to render_template("show")
	end
	it 'Does not show the problem bank for Student' do
		student = Student.new(email: '1@studentt.com', password: '123456789', 
		password_confirmation: '123456789', name: 'studentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, 
		gender: true, university: "GUC", faculty: "Engineering", semester: 6,major: "alwan")
		student.save!
		sign_in student
		get :show
		expect(response).not_to render_template("show")
	end

end