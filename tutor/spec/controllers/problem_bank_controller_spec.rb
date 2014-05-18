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
		degree: "BSc", graduated_from: "GUC", department: "MET", university: "GUC", 
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
	it 'Shows problem describtion successfully for lecturer/ta' do
		problem = Problem.first
		track_id = 1
		lecturer = Lecturer.new(email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		sign_in lecturer
		get 'index' , {:id => 1, :track_id => track_id}
		expect(response).to render_template("index")
	end
	it 'Does not Show problem describtion for student' do
		problem = Problem.first
		track_id = 1
		student = Student.new(email: '1@studentt.com', password: '123456789', 
		password_confirmation: '123456789', name: 'studentI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, 
		gender: true, university: "GUC", faculty: "Engineering", semester: 6,major: "alwan")
		student.save!
		sign_in student
		get 'index' , {:id => 1, :track_id => track_id}
		expect(response).not_to render_template("index")
	end
	it 'Add a problem from the bank and checks if the same reference of 
	the problem or a newly duplicated one' do
		Problem.create(id: 10, title: "Insertion Sort", description: "Given array of numbers 
		a use the insertion sort to sort them ascendingly",incomplete: true, seen:true)
		Problem.create(id: 11, title: "Insertions Sort", description: "Givenn array of numbers 
		a use the insertion sort to sort them ascendingly",incomplete: true, seen:true)
		lecturer = Lecturer.new(id: 101, email: '1@lecturer.com', password: '123456789', 
		password_confirmation: '123456789', name: 'LecturerI',
		confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
		degree: "PhD", university: "GUC", department: "MET")
		lecturer.save!
		sign_in lecturer
		Track.create(id: 1, title: "Track 1", difficulty: 0)
		Track.find_by_id(1).problems << Problem.find_by_id(11)
		Lecturer.find_by_id(101).tracks << Track.find_by_id(1)
		get 'add' , {:id => 10, :track_id => 1}
		expect(Track.find_by_id(1).problems).not_to include(Problem.find_by_id(10))
	end

end