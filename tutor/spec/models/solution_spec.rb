require 'spec_helper'

describe Solution do
 	context "Creations" do
		before(:all) do
			s = Student.create(email: '1@student.com', password: '123456789', 
				password_confirmation: '123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			@testcases = TestCase.create(output: "5\n", input:"10 2")
			problem.test_cases << @testcases
			@code = "public static void main(String [] args){}}"
			@student_id = 1
			@problem_id = problem.id
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id)
		end

		context "Execution" do
			it "TestCases Passed" do
				@code = "public static void main(String [] args){ System.out.println(5); }}"
				@solution.code = @code
				@solution.save
				expect(Solution.validate_code @solution, @testcases, "java").to eq "???????"
			end
	
			it "Logical Error in TestCases" do
				expect(Solution.validate_code @solution, @testcases, "java").to eq "??????????"
			end

			it "Runtime Error in TestCases" do
				@code = "public static void main(String [] args){ System.out.println(1/0); }}"
				@solution.code = @code
				@solution.save
				expect(Solution.validate_code @solution, @testcases, "java").to eq "??????????"
			end
		end
	end
end