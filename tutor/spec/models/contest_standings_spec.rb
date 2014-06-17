require 'spec_helper'

describe Contest do
	after(:all) do 
		Student.delte_all 
		Lecturer.delte_all 
		Student.delte_all 
		Cproblem.delte_all 
		Contest.delte_all 
		ContestProgress.delte_all 
	end
 	context "Creations" do
		before(:all) do

puts("# ----------------------- Lecturers ----------------------- ")
			l = Lecturer.new(email: '1@lecturer.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'LecturerI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				degree: "PhD", university: "GUC", department: "MET")
			l.save!

			s = Student.new(email: '1@student.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6,
				advising: false, probation: false)
			s.save!
			s = Student.new(email: '2@student.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'StudentII',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
				faculty: "Fac", university: "Uni", major: "Maj", semester: 6,
				advising: true, probation: true)
			s.save!
			s = Student.new(email: '3@student.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'StudentIII',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: false,
				faculty: "Fac", university: "Uni", major: "Maj", semester: 6,
				advising: false, probation: true)
			s.save!

			s = Student.new(email: '4@student.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'StudentIV',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "Fac", university: "Uni", major: "Maj", semester: 8,
				advising: true, probation: false)
			s.save!

puts("# ----------------------- cproblem ----------------------- ")
			## Contests
				Cproblem.create(title: "ContestProblem 1", 
					description: "This is very easy Problem")
				Cproblem.create(title: "ContestProblem 2", 
					description: "Given two numbers a and b, output a/b")
				Cproblem.create(title: "ContestProblem 3", 
					description: "This is very hard Problem")
				Cproblem.create(title: "ContestProblem 4", 
					description: "This wont be a hard Problem")
				Cproblem.create(title: "ContestProblem 5",
				 description: "This will be very easy Problem")
				Cproblem.create(title: "ContestProblem 6", 
					description: "This is very easy Problem")

puts("# ----------------------- Contest ----------------------- ")
	Contest.create(title: "Iteration", description: "If you can solve this you will get a level up",
		incomplete: false, start_time: Time.now + 1.second, end_time: Time.now + 7.days)
		sleep 3


puts("# ----------------------- contest_progresses ----------------------- ")
				ContestProgress.create!(status:true, trials: 1)
				ContestProgress.create!(status:true, trials: 2)
				ContestProgress.create!(status:false, trials: 5)
				ContestProgress.create!(status:true, trials: 3)
				ContestProgress.create!(status:false, trials: 1)
				ContestProgress.create!(status:false, trials: 2)
				ContestProgress.create!(status:true, trials:20)
				ContestProgress.create!(status:true, trials: 18)
				ContestProgress.create!(status:false, trials: 11)

puts("# ----------------------- Lecturers problems ----------------------- ")
				Lecturer.first.contest_problems << Cproblem.first
				Lecturer.first.contest_problems << Cproblem.find_by_id(2)
				Lecturer.first.contest_problems << Cproblem.find_by_id(3)
				Lecturer.first.contest_problems << Cproblem.find_by_id(4)
				Lecturer.first.contest_problems << Cproblem.find_by_id(5)
			## Contests
				Student.first.contests << Contest.first
				Student.find_by_id(2).contests << Contest.first
				Student.find_by_id(3).contests << Contest.first
				Student.find_by_id(4).contests << Contest.first

puts("# ----------------------- student contest progress ----------------------- ")				
			## Contests progress
				Student.first.contest_progresses << ContestProgress.first
				Student.first.contest_progresses << ContestProgress.find_by_id(2)
				Student.first.contest_progresses << ContestProgress.find_by_id(3)
				Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(4)
				Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(5)
				Student.find_by_id(2).contest_progresses << ContestProgress.find_by_id(6)
				Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(7)
				Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(8)
				Student.find_by_id(3).contest_progresses << ContestProgress.find_by_id(9)

puts("# ----------------------- cproblem contest progress ----------------------- ")				
			## Contest Progress
				Cproblem.find_by_id(1).contests_progresses << ContestProgress.first
				Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(2)
				Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(3)
				Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(4)
				Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(5)
				Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(6)
				Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(7)
				Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(8)
				Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(9)

puts("# ----------------------- problems contests_progresses ----------------------- ")
			## Problems
				Contest.first.problems << Cproblem.find_by_id(1)
				Contest.first.problems << Cproblem.find_by_id(2)
				Contest.first.problems << Cproblem.find_by_id(3)

puts("# ----------------------- contests contests_progresses ----------------------- ")
			## Contests Progress
				Contest.first.progress << ContestProgress.first
				Contest.first.progress << ContestProgress.find_by_id(2)
				Contest.first.progress << ContestProgress.find_by_id(3)
				Contest.first.progress << ContestProgress.find_by_id(4)
				Contest.first.progress << ContestProgress.find_by_id(5)
				Contest.first.progress << ContestProgress.find_by_id(6)
				Contest.first.progress << ContestProgress.find_by_id(7)
				Contest.first.progress << ContestProgress.find_by_id(8)
				Contest.first.progress << ContestProgress.find_by_id(9)


		end

		context "Execution" do
			it "TestCases Passed" do
				c = Contest.first
				result = Hash.new
				x = ContestProgress.new(id: 3, contest_id: 1, student_id: 1,
					cproblem_id: 3, trials: 5, status: false, created_at: Time.now)
				
				result[1] = {:wrong_answers=>1, :record=>x, :time_spent=>0}
				y = ContestProgress.new(id: 9, contest_id: 1, student_id: 3,
					cproblem_id: 3, trials: 11, status: false, created_at: Time.now)
				
				result[3] = {:wrong_answers=>1, :record=>y, :time_spent=>0}
				z = ContestProgress.new(id: 6, contest_id: 1, student_id: 2,
					cproblem_id: 3, trials: 2, status: false, created_at: Time.now)
				
				result[2] = {:wrong_answers=>2, :record=>z, :time_spent=>0}
				expect(c.get_contest_standings).to eq result 

			end
		end
	end
end