require 'spec_helper'

describe Solution do
 	context "Creations" do

 		before(:each) do
			@s = Student.create(email: '1@student.com', password: 'Aa123456789', 
					password_confirmation: 'Aa123456789', name: 'StudentI',
					confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
					faculty: "MET", university: "GUC", major: "CS", semester: 6, 
					advising: false, probation: false)
			@s.id = 1
			@s.save		
			@problem = Cproblem.create(title: "p1", description: "Given two numbers a and b, output a/b")
			@problem.save
			@testcase = TestCase.create(output: "5\n", input:"10 2")
			@problem.test_cases << @testcase
			@testcases = @problem.test_cases
			@code = "import java.util.*;public class Coolsoft{public static void main(String [] args){
				Scanner sc = new Scanner(System.in);
				int one = sc.nextInt();
				int two = sc.nextInt();
				System.out.println(one/two);
			}}"
			@student_id = 1
			@problem_id = @problem.id
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: "Cproblem", class_name: "Coolsoft")
			@solution.save
		end

		context "Execution" do
			it "TestCases Passed" do
				response  ={:success=>true, :test_case=>"10 2", :response=>"Passed!", :last=>false}, {:status=>1, :last=>true}
				JavaCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "java").to eq response
			end

			it "TestCases Logical Error" do
				@solution.code = "import java.util.*;public class Coolsoft{public static void main(String [] args){
						Scanner sc = new Scanner(System.in);
						int one = sc.nextInt();
						int two = sc.nextInt();
						System.out.print(two/two);
					}}"
				@solution.save
				response  ={:success=>false, :test_case=>"10 2", 
					response: "Logic error: Expected output: 5, but your output was: 1",
					last: false}, {:status=>5, :last=>true}
				JavaCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "java").to eq response
			end

			it "Contest Successful Submission" do
				contest = Contest.create(title:"Iteration", description:"If you can solve this you will get a level up",
						incomplete:false, start_time: DateTime.now, end_time: DateTime.now + 5)
				contest.save
				s = Student.create(email: '1@student.com', password: 'Aa123456789', 
					password_confirmation: 'Aa123456789', name: 'StudentI',
					confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
					faculty: "MET", university: "GUC", major: "CS", semester: 6, 
					advising: false, probation: false)
				s.save
				problem = Cproblem.create(title: "p1", description: "Given two numbers a and b, output a/b")
				problem.save
				ContestProgress.destroy_all
				Cproblem.submit(contest.id, problem.id, s.id, 1)
				progress = ContestProgress.last
				expect(progress.trials).to eq 1
				expect(progress.status).to eq true
			end

			it "Contest Contest 2 Failed Submisisons" do
				contest = Contest.create(title:"Iteration", description:"If you can solve this you will get a level up",
						incomplete:false, start_time: DateTime.now, end_time: DateTime.now + 5)
				contest.save
				s = Student.create(email: '1@student.com', password: 'Aa123456789', 
					password_confirmation: 'Aa123456789', name: 'StudentI',
					confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
					faculty: "MET", university: "GUC", major: "CS", semester: 6, 
					advising: false, probation: false)
				s.save
				problem = Cproblem.create(title: "p1", description: "Given two numbers a and b, output a/b")
				problem.save
				ContestProgress.destroy_all
				Cproblem.submit(contest.id, problem.id, s.id, 0)
				Cproblem.submit(contest.id, problem.id, s.id, 0)
				progress = ContestProgress.last
				expect(progress.trials).to eq 2
				expect(progress.status).to eq false
			end
		end
	end
end