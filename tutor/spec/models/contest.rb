require 'spec_helper'

describe Contest do
 	context "Creations" do
		before(:all) do
			Cproblem.create(title: "ContestProblem 1", description: "This is very easy Problem")
			Cproblem.create(title: "ContestProblem 2", description: "Given two numbers a and b, output a/b")
			Cproblem.create(title: "ContestProblem 3", description: "This is very hard Problem")

			contest = 	Contest.create(title:"Iteration", description:"If you can solve this you will get a level up",
			incomplete:false, start_time: DateTime.now, end_time:  DateTime.new(2014, 6, 1, 5, 44, 2))

			ContestProgress.create!(status:true, trials: 1)
			ContestProgress.create!(status:false, trials: 2)
			ContestProgress.create!(status:true, trials: 5)
			ContestProgress.create!(status:false, trials: 3)
			ContestProgress.create!(status:false, trials: 1)
			ContestProgress.create!(status:true, trials: 2)
			ContestProgress.create!(status:false, trials:20)
			ContestProgress.create!(status:true, trials: 18)
			ContestProgress.create!(status:true, trials: 11)

			## Problems
			Contest.first.problems << Cproblem.find_by_id(1)
			Contest.first.problems << Cproblem.find_by_id(2)
			Contest.first.problems << Cproblem.find_by_id(3)

			## Contests
			Student.first.contests << Contest.first
			Student.find_by_id(2).contests << Contest.first
			Student.find_by_id(3).contests << Contest.first
			Student.find_by_id(4).contests << Contest.first
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

			Cproblem.find_by_id(1).contests_progresses << ContestProgress.first
			Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(2)
			Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(3)
			Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(4)
			Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(5)
			Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(6)
			Cproblem.find_by_id(1).contests_progresses << ContestProgress.find_by_id(7)
			Cproblem.find_by_id(2).contests_progresses << ContestProgress.find_by_id(8)
			Cproblem.find_by_id(3).contests_progresses << ContestProgress.find_by_id(9)

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
				expect(Contest.get_contest_standings).to eq ""
			end
		end
	end
end