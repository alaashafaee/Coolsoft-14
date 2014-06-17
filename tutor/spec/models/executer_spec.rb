require 'spec_helper'

describe Executer do

	context "get_executer tests" do
		it "get java executer" do
			expect(SolutionsLayer.get_executer "java").to eq JavaExecuter
		end

		it "get python executer" do
			expect(SolutionsLayer.get_executer "python").to eq PythonExecuter
		end
	
		it "no such executer named foo" do
			expect(SolutionsLayer.get_executer "foo").to eq false
		end
	end

	context "execut with python" do
		before(:all) do
			s = Student.create(email: '1@student.com', password: 'Aa123456789',
				password_confirmation: 'Aa123456789', name: 'StudentI',
				confirmed_at: Time.now, dob: DateTime.now.to_date, gender: true,
				faculty: "MET", university: "GUC", major: "CS", semester: 6, 
				advising: false, probation: false)
			problem = Problem.create(title: "Problem 1",
				description: "Given two numbers a and b, output a/b", incomplete: false)
			test_cases = TestCase.create(output: "5\n", input:"10\n2")
			problem.test_cases << test_cases
			@code = "import sys\ndef CoolSoft():\n\tx = raw_input()\n\ty = raw_input()\n\tprint int(x)/int(y)\nCoolSoft()"
			@student_id = 1
			@problem_id = problem.id
			@lang = "python"
			@cases1 = "10\n2"
			@cases2 = "10"
			@problem_type = "Problem"
			@class_name = "Coolsoft"
			@solution = Solution.create(code: @code, student_id: @student_id,
				problem_id: @problem_id, problem_type: @problem_type, class_name: @class_name)
		end

		context "executer" do
			it "get_executer was called and PythonExecuter was returned" do
				expect(SolutionsLayer).to receive(:get_executer).with("python"){PythonExecuter}
				SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases1)
			end

			it "Compiled successfuly but wrong input" do
				feed_back = SolutionsLayer.execute(@lang, @code, @student_id,
					@problem_id, @problem_type, @class_name, @cases2)
				count = @cases1.split("\n").count
				msg = "Enter only " + count.to_s + " inputs"
				expected_hash = {executer_feedback: false, executer_output: msg}
				expect(feed_back).to eq expected_hash
			end

			it "Run with arithmatic exception" do
				wrong_cases = "10\n0"
				feed_back = SolutionsLayer.execute(@lang, @code, @student_id,
							@problem_id, @problem_type, @class_name, wrong_cases)
				message = "Division by Zero results in infinity, " +
				"which computers can not understand. Be careful !"
				exception = feed_back[:executer_output][:errors]
				runtime_err = {errors: exception, explanation: message}
				expected_hash = {executer_feedback: false, executer_output: runtime_err}
				expect(feed_back).to eq expected_hash
			end

			it "Compiled successfuly and run successfuly with output" do
				feed_back = SolutionsLayer.execute(@lang, @code, @student_id,
							@problem_id, @problem_type, @class_name, @cases1)
				expected_hash = {executer_feedback: true,
					executer_output: {success: true, message: "5\n"}}
				expect(feed_back).to eq expected_hash
			end
		end

	end

end