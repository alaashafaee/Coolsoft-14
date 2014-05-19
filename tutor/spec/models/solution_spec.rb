require 'spec_helper'

describe Solution do
 	context "Creations" do
		before(:each) do
			s = Student.create(email: '1@student.com', password: 'Aa123456789', 
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			testcase = TestCase.create(output: "5\n", input:"10\n2")
			problem.test_cases << testcase
			@testcases = problem.test_cases
			@code = "public class Coolsoft{public static void main(String [] args){}}"
			@student_id = 1
			@problem_id = problem.id
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: "Problem", class_name: "Coolsoft")
		end

		context "Java Execution" do
			it "TestCases Passed" do
				@code = "public class Coolsoft{public static void main(String [] args){ System.out.println(5); }}"
				@solution.code = @code
				@solution.save
				response  = {:success=>true, :test_case=>"10\n2", :response=>"Passed!"},
					{:status=>1, :last=>true}
				JavaCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "java").to eq response
			end
	
			it "Logical Error in TestCases" do
				@code = "public class Coolsoft{public static void main(String [] args){ System.out.println(1); }}"
				@solution.code = @code
				@solution.save
				response = {:success=>false, :test_case=>"10\n2",
				:response=>"Logic error: Expected output: 5, but your output was: 1\n"},
					{:status=>5, :last=>true}
				JavaCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "java").to eq response
			end

			it "Runtime Error in TestCases" do
				@code = "public class Coolsoft{public static void main(String [] args){ System.out.println(1/0); }}"
				@solution.code = @code
				@solution.save
				response = {:success=>false, :test_case=>"10\n2",
					:response=>"Runtime error: Division by zero, for example: a/b, b = 0"},
					{:status=>4, :last=>true}
				JavaCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "java").to eq response
			end
		end

		context "Python Execution" do
			it "TestCases Passed" do
				@code = "print 5"
				@solution.code = @code
				@solution.save
				response  = {:success=>true, :test_case=>"10\n2", :response=>"Passed!"},
					{:status=>1, :last=>true}
				PythonCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "python").to eq response
			end
	
			it "Logical Error in TestCases" do
				@code = "print 1"
				@solution.code = @code
				@solution.save
				response = {:success=>false, :test_case=>"10\n2",
				:response=>"Logic error: Expected output: 5, but your output was: 1\n"},
					{:status=>5, :last=>true}
				PythonCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "python").to eq response
			end

			it "Runtime Error in TestCases" do
				@code = "print 1/0"
				@solution.code = @code
				@solution.save
				response = {:success=>false, :test_case=>"10\n2", :response=>"Runtime error:" +
					" Traceback (most recent call last):\n  File \"Coolsoft.py\", line 1," +
					" in <module>\n    print 1/0\nZeroDivisionError: integer division or " +
					"modulo by zero\n"}, {:status=>4, :last=>true}
				PythonCompiler.compiler_feedback @solution
				expect(Solution.validate @solution, @testcases, "python").to eq response
			end
		end
	end
end